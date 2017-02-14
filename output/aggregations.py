from epa.output.handlers import HandlersAggregation
from epa.output.investigations import InvestigationsAggregation
from epa.output.icis import IcisFecAggregation
from epa.output.manifest import ManifestAggregation
from epa.output.manifest_monthly import ManifestMonthlyAggregation
from epa.output.br import BrAggregation 
from epa.output.nysdec_reports import NYSDECReportsAggregation 

from drain import util
from datetime import date
from repoze.lru import lru_cache

indexes = {'facility': 'rcra_id', 
           'zip': 'zip_code', 
           'entity': 'entity_id'}

deltas = {'facility' : ['1y', '5y', 'all'],
          'zip': ['2y'],
          'entity': ['5y']}

manifest_deltas = {'facility' : ['6m', '1y', '5y', 'all'],
                   'zip': ['2y'],
                   'entity': ['5y']}

manifest_monthly_deltas = {'facility' : ['3y', 'all'] }

#Spacedeltas: what we will be aggregating over (what we are grouping over)?
spacedeltas = {index: (indexes[index], deltas[index]) for index in deltas}
manifest_spacedeltas = {index: (indexes[index], manifest_deltas[index])
        for index in manifest_deltas}
manifest_monthly_spacedeltas = {index: (indexes[index], manifest_monthly_deltas[index])
        for index in manifest_monthly_deltas}

#dates here is our prediction window of dates?
dates = tuple(date(y,1,1) for y in range(2007,2017+1))

aggregations = {'handlers': HandlersAggregation, 
                'icis_fec': IcisFecAggregation, 
                'investigations': InvestigationsAggregation,
                'manifest': ManifestAggregation, 
                'manifest_monthly': ManifestMonthlyAggregation, 
                'br': BrAggregation,
                'nysdec_reports': NYSDECReportsAggregation}

spacedeltas = {'handlers': spacedeltas, 
               'icis_fec': util.dict_subset(spacedeltas, ['facility']),
               'investigations': spacedeltas,
               'manifest': manifest_spacedeltas, 
               'manifest_monthly': manifest_monthly_spacedeltas,
               'br': spacedeltas,
               'nysdec_reports': spacedeltas}

def nysdec_reports(dates=dates):
    return NYSDECReportsAggregation(spacedeltas, dates=dates)

@lru_cache(maxsize=10)
def all_dict(dates=dates):
    d = {k: aggregations[k](spacedeltas[k], dates=dates) for k in aggregations.keys()}   
    # set parallel aggregations to be targets
    for a in d.values():
        for i in a.inputs:
            i.target = True

    return d

def all(dates=dates):
    return all_dict(dates).values()
