import sys

with open(sys.argv[1], 'r') as sql_file:
    sql = sql_file.read().format(min_year=sys.argv[2], max_year=sys.argv[3],
            month=sys.argv[4], day=sys.argv[5])

    print sql
