
from drain.util import read_file
from drain.data import date_censor_sql
import os

censor_dates = {'gen_sign_date': ['gen_sign_date'],
		'tsdf_sign_date': ['tsdf_sign_date'],
		'transporter_1_sign_date':['transporter_1_sign_date'],
		'transporter_2_sign_date':['transporter_2_sign_date'],
		'alt_facility_sign_date':['alt_facility_sign_date']}

date_columns = list(censor_dates.keys()) 

def get_sql(date):
	sql = read_file(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'manifests.sql'))
	format_vars = {}
	for d in dates:
		format_vars{d} = date_censor_sql(d,date)
		format_var.update({c: date_censor_sql(d, date, c) for c in censor_dates[d]})
	format_vars['dates'] = str.join(',', date_columns + ['gen_sign_date'])
	return sql.format(**format_vars)

if __name__ == '__main__':
	print(get_sql(None))


