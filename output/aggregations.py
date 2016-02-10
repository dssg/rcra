from epa.output.handlers import HandlersAggregation
from datetime import date

indexes = {'facility': 'rcra_id' }

deltas = {'facility' : ['5y', 'all']}

spacedeltas = {index: (indexes[index], deltas[index]) for index in deltas}

dates = [date(y,1,1) for y in range(2004,2014+1)]

def handlers():
    return HandlersAggregation(spacedeltas, dates, target=True, parallel=True)
