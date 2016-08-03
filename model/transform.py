from epa.model.data import EpaData
from epa.model.reader import EpaHDFReader

from drain.data import ToHDF, index_as_series
from drain import data, aggregate, util
from drain.step import Step

import os
from datetime import date,datetime
import logging
import pandas as pd
import numpy as np

class EpaTransform(Step):
    """Handles transformation of the data from a large table to a format 
    that can be inputted into the models. The run method outputs a design matrix, a response vector,
    aux, a train and a test set.  
    """
    def __init__(self, month, day,
            year, train_years, 
            outcome_expr,
            train_query,
            evaluation, # whether the outcome is an evaluation, hence include unevaluated facilities
            region=None,
            investigations={},
            handlers={},
            icis={},
            rmp={},
            investigations_expand_counts=False,
            exclude=[], include=[],
            impute=True, normalize=True, **kwargs):
        # Includes or excludes certain features
        exclude = set(exclude)
        include = set(include)

        Step.__init__(self, month=month, day=day, year=year, 
                train_years=train_years, region=region,
                outcome_expr=outcome_expr,
                train_query = train_query,
                evaluation = evaluation,
                investigations=investigations, handlers=handlers, 
                icis=icis, rmp=rmp,
                investigations_expand_counts=investigations_expand_counts,
                exclude=exclude, include=include, impute=impute, normalize=normalize, **kwargs)

    # The EpaData class 
        self.data = EpaData(month=month, day=day)

    # The ToHDF class writes dataframes to a HDF store 
        store = ToHDF(inputs=[self.data], 
            put_args={'X':dict(format='t', data_columns=['date', 'evaluation'])})
        self.inputs = [EpaHDFReader(year=year, train_years=train_years, evaluation=self.evaluation, region=region, inputs=[store])]

    def run(self, X, aux, **kwargs):
        """ Transforms and reshapes the data so that it can be fed into models
        Args:
            X: A design matrix
            aux: Contains information about each example (metadata). Has same index as X and y and is used for post analysis
            information        
        Returns: 
            A dictionary containing the design matrix (X), the response (y), aux (aux), the train set (train)
            and the test set (test). The train and test variables are a mask which assign each row of X and y to the 
            train or test set.
        """
        # Drops unnecessary regions if a specific region only is required.
        if self.region is not None:
            X.drop(X.index[aux.region != self.region], inplace=True)
            aux.drop(aux.index[aux.region != self.region], inplace=True)

        logging.info('Selecting spatiotemporal aggregations')
        aggregators = self.data.aggregators

#        X = aggregators['investigations'].select(X, self.investigations)
#        X = aggregators['handlers'].select(X, self.handlers)
#        X = aggregators['icis'].select(X, self.icis)
#        X = aggregators['rmp'].select(X, self.icis)

        logging.info('Splitting train and test sets')
        today = date(self.year, self.month, self.day)
        train = index_as_series(aux, 'date') < today
        test = ~train

        train &= eval(self.train_query)

        # reshape to train | test
        aux.drop(aux.index[~(train | test)], inplace=True)
        X,train,test = data.train_test_subset(X, train, test)

        y = eval(self.outcome_expr)

        X = data.select_features(X, exclude=self.exclude, include=self.include)

        # If impute(fix missing values) and normalize have been passed it performs those actions
        if self.impute:
            logging.info('Imputing')
            X = data.impute(X, train=train)
            if self.normalize:
                logging.info('Normalizing')
                X = data.normalize(X, train=train) 

        return {'X': X, 'y': y, 'aux': aux, 'train': train, 'test':test}
