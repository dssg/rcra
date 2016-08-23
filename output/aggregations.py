from epa.output.handlers import HandlersAggregation
from epa.output.investigations import InvestigationsAggregation
from epa.output.icis import IcisFecAggregation
from epa.output.rmp import RmpAggregation
from epa.output.manifest import ManifestAggregation
from epa.output.br import BrAggregation 

from drain import util
from datetime import date
from repoze.lru import lru_cache

# TODO: zip level agg
indexes = {'facility': 'rcra_id', 'state':'state','zip':'handler_zip_code'}

deltas = {'facility' : ['1y', '5y', 'all'],
#          'state': ['2y']
        }


#Spacedeltas: what we will be aggregating over (what we are grouping over)?
spacedeltas = {index: (indexes[index], deltas[index]) for index in deltas}

#dates here is our prediction window of dates?
dates = [date(y,1,1) for y in range(2007,2016+1)]

def handlers(dates=dates):
    return HandlersAggregation(spacedeltas, dates, target=True, parallel=True)

def icis(dates=dates):
    return IcisFecAggregation(util.dict_subset(spacedeltas, ['facility']), dates, target=True, parallel=True)

def rmp(dates=dates):
    return RmpAggregation(util.dict_subset(spacedeltas, ['facility']), dates, target=True, parallel=True)

def investigations(dates=dates):
    return InvestigationsAggregation(spacedeltas, dates=dates, parallel=True, target=True)

def manifest(dates=dates):
	return ManifestAggregation(spacedeltas, dates=dates, parallel=True, target=True)

def br(dates=dates):
    return BrAggregation(spacedeltas, dates=dates, parallel=True, target=True)

@lru_cache(maxsize=10)
def all_dict(dates=dates):
    return {
        'handlers':handlers(dates), 
        'investigations':investigations(dates),
        'icis': icis(dates), 
        'rmp': rmp(dates),
	    'manifest': manifest(dates),
	    'br':br(dates)
    }

def all(dates=dates):
    return all_dict(dates).values()
