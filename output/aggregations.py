from epa.output.handlers import HandlersAggregation
from epa.output.investigations import InvestigationsAggregation, Investigations
from drain import util
from datetime import date

# TODO: zip level agg
indexes = {'facility': 'rcra_id', 'state':'state'}

deltas = {'facility' : ['1y', '5y', 'all'],
         # 'state': ['1y','2y', '5y']
        }

spacedeltas = {index: (indexes[index], deltas[index]) for index in deltas}

dates = [date(y,1,1) for y in range(2004,2014+1)]

def handlers(dates=dates):
    return HandlersAggregation(spacedeltas, dates, target=True, parallel=True)

def investigations(dates=dates):
    return InvestigationsAggregation(util.dict_subset(spacedeltas, ['facility']), dates, parallel=True, target=True)

def all():
    return [handlers(), investigations()]
