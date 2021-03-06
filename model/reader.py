from drain import data, util
from drain.step import Step

import os
import logging
import pandas as pd

class EpaHDFReader(Step):
    def __init__(self, year, train_years, evaluation, inputs, region=None):
        Step.__init__(self, year=year, train_years=train_years, 
                evaluation=evaluation, inputs=inputs, region=region)

    def run(self, store):
        data = self.inputs[0].inputs[0]

        doy =  '%02d-%02d' % (data.month, data.day)
        where_test = "date == '{year}-{doy}'".format(year=self.year, doy=doy)
        where_train = "date >= '{year_min}-{doy}' and date < '{year}-{doy}'".format(
                year_min=self.year-self.train_years, year=self.year, doy=doy)
        if not self.evaluation:
            where_train = "({where_train}) & (evaluation > 0)".format(where_train=where_train)
        where = "({where_train}) | ({where_test})".format(where_train=where_train, where_test=where_test)
        # HDF bug makes this not work. because region isn't in the index? neither is evaluation though
        #if self.region is not None:
        #    where = "(region == {region}) & ({where})".format(region=self.region, where=where)
        logging.info('Reading X')
        #X = store.select('X', where=where)
        X = store['X']
        X = X.query(where)

        # evaluation shouldn't be part of X
        X.drop(['evaluation'], axis=1, inplace=True)

        logging.info('Reading aux')
        aux = store['aux']
        aux = aux.query(where) 

        return {'X':X, 'aux': aux}
