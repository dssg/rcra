import sys
import os
import dateutil
import logging
from datetime import date, datetime

import pandas as pd
import numpy as np

from drain import util, aggregate, data
from drain.aggregate import Aggregate, Count, aggregate_counts, SpacetimeAggregator, Spacedeltas

day = np.timedelta64(1, 'D')

class ICISAggregator(SpacetimeAggregator):
    
    bool_columns = ['lead_agency_epa', 'multimedia_flag']
    
    money_columns = ['total_comp_action_amt', 'total_cost_recovery_amt',
                         'total_penalty_assessed_amt', 'fed_penalty', 'st_lcl_penalty', 'total_sep', 'compliance_action_cost',
                         'federal_cost_recovery_amt', 'state_local_cost_recovery_amt']


    def __init__(self, basedir, psql_dir=''):
        SpacetimeAggregator.__init__(self, 
                spacedeltas = {
                    'facility':Spacedeltas('rcra_id',['all', '5y', '2y', '1y'])
                },
                dates = [date(y,1,1) for y in xrange(2004,2014+1)],
                prefix = 'icis_fec',
                basedir = basedir,
                date_col = 'activity_status_date')

        self.DEPENDENCIES = [os.path.join(psql_dir, 'output/icis_fec')]
        self.dtypes = np.float32

    def get_data(self, date):
        engine = util.create_engine()
        logging.info('Reading ICIS FEC %s' % date)
        df = pd.read_sql("select * from output.icis_fec where activity_status_date < '%s'" % date, engine, parse_dates=['activity_status_date'])
  

        return df

    def get_aggregates(self, date, data):
        
        # leave out: activity_status_date, rcra_id, activity_id, registry_id
        # categorical: activity_type_code, epa_division,
        # counts: violation_type_count, enf_type_count, relief_type_count,

         aggregates = [Count(c) for c in data.columns if c not in ['activity_status_date', 'rcra_id', 
                                                                   'activity_id', 'registry_id'],
                       Count(c, prop=True) for c in self.bool_columns,
                       Aggregate(c, ['max','mean','min']) for c in self.money_columns] 


         return aggregates
