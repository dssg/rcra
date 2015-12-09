import sys
from drain import util

with open(sys.argv[1], 'r') as sql_file:
    sql = sql_file.read().format(min_year=sys.argv[2], max_year=sys.argv[3],
            doy=sys.argv[4], table_suffix=sys.argv[4].replace('-',''))

engine = util.create_engine()
util.execute_sql(sql, engine)
