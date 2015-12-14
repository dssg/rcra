import sys
import os
import dateutil
import logging
from datetime import date, datetime

import pandas as pd
import numpy as np

from drain import util, aggregate, data
from drain.aggregate import Aggregate, Count, aggregate_counts, SpacetimeAggregator, Spacedeltas

from epa.output.investigations import get_investigations

day = np.timedelta64(1, 'D')

class HandlersAggregator(SpacetimeAggregator):
    def __init__(self, basedir, psql_dir=''):
        SpacetimeAggregator.__init__(self, 
                spacedeltas = {
                    'facility':Spacedeltas('rcra_id',['all', '5y'])#'all', '5y', '1y']),
                },
                dates = [date(y,1,1) for y in xrange(2004,2014+1)],
                prefix = 'handlers',
                basedir = basedir,
                date_col = 'receive_date')

        self.DEPENDENCIES = [os.path.join(psql_dir, 'output/handlers')]
        self.dtypes = np.float32

    def get_data(self, date):
        engine = util.create_engine()
        logging.info('Reading handlers %s' % date)
        df = pd.read_sql("select * from output.handlers where receive_date < '%s'" % date, engine, parse_dates=['receive_date'])

        return df

    def get_aggregates(self, date, data):
         aggregates = [Count(c, prop=True) for c in data.columns if c not in ('rcra_id', 'receive_date', 'handler_id')]
         aggregates.append(Count())

         return aggregates
