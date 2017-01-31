from epa.output.handlers import HandlersAggregation
from epa.output.investigations import InvestigationsAggregation
from epa.output.icis import IcisFecAggregation
from epa.output.rmp import RmpAggregation
from epa.output.manifest import ManifestAggregation
from epa.output.manifest_monthly import ManifestMonthlyAggregation
from epa.output.br import BrAggregation 
from epa.output.nysdec_reports import NYSDECReportsAggregation 

from drain import util
from datetime import date
from repoze.lru import lru_cache

# TODO: zip level agg
indexes = {'facility': 'rcra_id', 'state':'state'}
#indexes = {'facility': 'rcra_id', 'state':'state','zip':'handler_zip_code'}

deltas = {'facility' : ['1y', '5y', 'all'],
#          'state': ['2y']
        }

manifest_deltas = {'facility' : ['6m', '1y', '5y', 'all'], }
manifest_monthly_deltas = {'facility' : ['3y', 'all'] }

#Spacedeltas: what we will be aggregating over (what we are grouping over)?
spacedeltas = {index: (indexes[index], deltas[index]) for index in deltas}
manifest_spacedeltas = {index: (indexes[index], manifest_deltas[index])
        for index in manifest_deltas}
manifest_monthly_spacedeltas = {index: (indexes[index], manifest_monthly_deltas[index])
        for index in manifest_monthly_deltas}

#dates here is our prediction window of dates?
dates = tuple(date(y,1,1) for y in range(2007,2017+1))

def handlers(dates=dates):
    return HandlersAggregation(spacedeltas, dates)

def icis(dates=dates):
    return IcisFecAggregation(util.dict_subset(spacedeltas, ['facility']), dates)

def rmp(dates=dates):
    return RmpAggregation(util.dict_subset(spacedeltas, ['facility']), dates)

def investigations(dates=dates):
    return InvestigationsAggregation(spacedeltas, dates=dates)

def manifest(dates=dates):
    return ManifestAggregation(manifest_spacedeltas, dates=dates)

def manifest_monthly(dates=dates):
    return ManifestMonthlyAggregation(manifest_monthly_spacedeltas, dates=dates)

def br(dates=dates):
    return BrAggregation(spacedeltas, dates=dates)

def nysdec_reports(dates=dates):
    return NYSDECReportsAggregation(spacedeltas, dates=dates)

@lru_cache(maxsize=10)
def all_dict(dates=dates):
    d = {
        'handlers':handlers(dates), 
        'investigations':investigations(dates),
        'icis': icis(dates), 
        #'rmp': rmp(dates),
	'manifest': manifest(dates),
	'manifest_monthly': manifest_monthly(dates),
	'br':br(dates),
        'nysdec_reports':nysdec_reports(dates)
    }
   
    # set parallel aggregations to be targets
    for a in d.values():
        for i in a.inputs:
            i.target = True

    return d

def all(dates=dates):
    return all_dict(dates).values()
