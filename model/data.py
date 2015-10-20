from drain.data import ModelData
from drain import util
import os
import pandas as pd

class EpaData(ModelData):
    def __init__(self, today, past_years=None):
        self.today = today
        self.past_years = past_years

    def read(self, directory=None):
        if directory is not None:
            self.df = pd.read_hdf(os.path.join(directory, 'df.h5'), 'df')
            return

        engine = util.create_engine()
        df = pd.read_sql('select * from output.inspections', engine)
        self.df = df

    def write(self, directory):
        self.df.to_hdf(os.path.join(directory, 'df.h5'), 'df', mode='w')
