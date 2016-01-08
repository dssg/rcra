from drain import data, util
from drain.drain import Step

import os
import logging
import pandas as pd

class EpaHDFReader(Step):
    #def __init__(self, year, month, day, train_years, evaluation, region=None):
    def __init__(self, year, train_years, evaluation, region=None, **kwargs):
        Step.__init__(self, year=year, train_years=train_years, evaluation=evaluation, region=region, **kwargs)

    def run(self):
        store = self.inputs[0].result
        data = self.inputs[0].inputs[0]

        doy =  '%02d-%02d' % (data.month, data.day)
        where_test = "date == '{year}-{doy}'".format(year=self.year, doy=doy)
        where_train = "date >= '{year_min}-{doy}' and date < '{year}-{doy}'".format(
                year_min=self.year-self.train_years, year=self.year, doy=doy)
        if not self.evaluation:
            where_train = "({where_train}) & (evaluation > 0)".format(where_train=where_train)
        where = "({where_train}) | ({where_test})".format(where_train=where_train, where_test=where_test)
        if self.region is not None:
            where = "(region == {region}) & ({where})",format(region=self.region, where=where)
        
        logging.info('Reading X')
        X = store.select('X', where=where)
        X.drop(['evaluation', 'region'], axis=1, inplace=True)

        logging.info('Reading aux')
        aux = store['aux']
        aux = aux.query(where) 

        self.result = {'X':X, 'aux': aux}
