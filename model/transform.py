from epa.model.data import EpaData, EpaHDFStore
from epa.model.reader import EpaHDFReader

from drain.util import index_as_series
from drain import data, aggregate, util
from drain.drain import Step

import os
from datetime import date,datetime
import logging
import pandas as pd
import numpy as np

class EpaTransform(Step):

    def __init__(self, month, day,
            year, train_years, region=None,
            outcome='violation_epa', # when None training_outcome=testin_outcome
            training_outcome = None,
            # the max handler age to be included (in addition to active_today) in all testing and evaluation training
            training_handler_max_age = 365,
            investigations={},
            handlers={},
            investigations_expand_counts=False,
            exclude=[], include=[],
            impute=True, normalize=True, **kwargs):

        if training_outcome is None:
            training_outcome = outcome

        exclude = set(exclude)
        include = set(include)

        Step.__init__(self, month=month, day=day, year=year, train_years=train_years,
                outcome=outcome, training_outcome=training_outcome, 
                investigations=investigations, handlers=handlers, investigations_expand_counts=investigations_expand_counts,
                exclude=exclude, include=include, impute=impute, normalize=normalize, **kwargs)

        self.evaluation = self.training_outcome.startswith('evaluation')

        self.data = EpaData(month=month, day=day)
        self.hdf = EpaHDFStore(target=True, inputs=[self.data])
        self.inputs = [EpaHDFReader(year=year, train_years=train_years, evaluation=self.evaluation, region=region, inputs=[self.hdf])]

    def run(self):
        X = self.inputs[0].result['X']
        aux = self.inputs[0].result['aux']
        aggregators = self.data.aggregators

        logging.info('Splitting train and test sets')
        today = date(self.year, self.month, self.day)

        X = aggregators['investigations'].select(X, self.investigations)
        X = aggregators['handlers'].select(X, self.handlers)

        train = index_as_series(aux, 'date') < today
        test = ~train

        if not self.evaluation:
	    # training set for violation(|_epa|_state) is evaluation(|_epa|_state)
            train = train & aux[self.training_outcome].notnull()
        else:
            # training set for evaluation is (active today or evaluated or handler under 1 year old)
            train = train & ( aux.active_today | aux.evaluation | (aux.handler_age < self.training_handler_max_age))
        # note test set is independent of outcome

        # reshape to train | test
        aux.drop(aux.index[~(train | test)], inplace=True)
        X,train,test = data.train_test_subset(X, train, test)
        self.cv = (train, test)

        # set violation in training set
        # censor formal enforcements based on corresponding min date
        if self.training_outcome.startswith('formal_enforcement'):
            y = aux[self.training_outcome].where(test | (aux['min_%s_date' % self.training_outcome] < today), False)
        else:
            y = aux[self.training_outcome].copy()

        y.loc[test] = aux.loc[test, self.outcome]

        X = data.select_features(X, exclude=self.exclude, include=self.include)
        
        if self.impute:
            logging.info('Imputing')
            X.fillna(0, inplace=True)
            if self.normalize:
                logging.info('Normalizing')
                X = data.normalize(X, train=train) 

        self.result = {'X': X, 'y': y, 'aux': aux}
