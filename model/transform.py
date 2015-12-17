from drain.util import index_as_series
from drain import data, aggregate, util

from epa.model.reader import EpaReader

import os
from datetime import date,datetime
import logging
import pandas as pd
import numpy as np

class EpaTransform(object):

    def __init__(self, year, train_years, month=1, day=1, outcome_years=1,
            outcome='violation_epa', # when None training_outcome=testin_outcome
            region = 0,
            training_outcome = None,
            # the max handler age to be included (in addition to active_today) in all testing and evaluation training
            training_handler_max_age = 365,
            investigations={},
            handlers={},
            investigations_expand_counts=False,
            exclude=[], include=[],
            impute=True, normalize=True):

        if outcome_years != 1:
            raise NotImplementedError('Currently only outcome_years=1 is implemented')

        self.year = year
        self.month = month
        self.day = day
        self.outcome_years = outcome_years

        self.testing_outcome = outcome
        if training_outcome is None:
            training_outcome = outcome

        self.region = region
        self.training_outcome = training_outcome
        self.training_handler_max_age = training_handler_max_age
        self.investigations = investigations
        self.handlers = handlers
        self.exclude = set(exclude)
        self.include = set(include)
        self.impute = impute
        self.normalize = normalize
 
        self.evaluation = self.training_outcome.startswith('evaluation')
        self.inputs = [EpaReader(year=year, month=month, day=day, train_years=train_years, evaluation=self.evaluation)]

    def run(self):
        logging.info('Reading data')
	# TODO: replace this with input steps and .load()
        self.inputs[0].run()
        df = self.inputs[0].df
        aux = self.inputs[0].aux
        epa_data = self.inputs[0].inputs[0]

        logging.info('Splitting train and test sets')
        today = date(self.year, self.month, self.day)

        df = epa_data.aggregators['investigations'].select(df, self.investigations)
        df = epa_data.aggregators['handlers'].select(df, self.handlers)

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
        df,train,test = data.train_test_subset(df, train, test)
        self.cv = (train, test)

        # set violation in training set
        # censor formal enforcements based on corresponding min date
        if self.training_outcome.startswith('formal_enforcement'):
            y = aux[self.training_outcome].where(test | (aux['min_%s_date' % self.training_outcome] < today), False)
        else:
            y = aux[self.training_outcome].copy()

        y.loc[test] = aux.loc[test, self.testing_outcome]

        X = data.select_features(df, exclude=self.exclude, include=self.include)
        
        if self.impute:
            logging.info('Imputing')
            X.fillna(0, inplace=True)
            if self.normalize:
                logging.info('Normalizing')
                X = data.normalize(X, train=train) 

        self.X = X
        self.aux = aux
        self.y = y
