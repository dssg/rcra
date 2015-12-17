from drain import data, util, model
from epa.model.data import EpaData

import os
import logging
import pandas as pd

class EpaReader(object):
    def __init__(self, year, month, day, train_years, evaluation, region=None):
        self.month = month
        self.day = day
        self.year = year
        self.train_years = train_years
        self.evaluation = evaluation
        self.region = region

        self.inputs = [EpaData(month=month, day=day)]
        self.input_params = [{'data': {'name':'epa.model.data.EpaData', 'month':month, 'day':day}}]

    def run(self):
        doy =  '%02d-%02d' % (self.month, self.day)
        where_test = "date == '{year}-{doy}'".format(year=self.year, doy=doy)
        where_train = "date >= '{year_min}-{doy}' and date < '{year}-{doy}'".format(
                year_min=self.year-self.train_years, year=self.year, doy=doy)
        if not self.evaluation:
            where_train = "({where_train}) & (evaluation > 0)".format(where_train=where_train)
        where = "({where_train}) | ({where_test})".format(where_train=where_train, where_test=where_test)
        if self.region is not None:
            where = "(region == {region}) & ({where})",format(region=self.region, where=where)
        
        dirname = os.path.join(model.params_dir(self.input_params[0]), 'output')

        df = pd.read_hdf(os.path.join(dirname, 'df.h5'), 'df' , where=where)
        df.drop(['evaluation', 'region'], axis=1, inplace=True)

        aux = pd.read_hdf(os.path.join(dirname, 'aux.h5'), 'df')
        aux = aux.query(where) 
        aux.set_index(['rcra_id', 'date'], inplace=True)

        self.df = df
        self.aux = aux
