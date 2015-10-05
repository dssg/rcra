"""
This script will generate three files based on two inputs. 

Usage: 
python xls2csv.py data_dictionary prefix_for_tables

The script will output: 

table_schema.csv - Schema files for the flat files based on the data_dictionary

create_table_prefix.sql - CREATE TABLE statements for files in the data_dictionary 
drop_table_prefix.sql - DROP TABLE statements for files in the data_dictionary 

load_prefix_csv.sh:
    > Drops Tables
    > Create Tables
    > Load Data

assumes data is here - /mnt/data/epa/RCRA_flat_files
"""
import pandas as pd
import re, unicodedata, os, sys

sys.path.insert(0, os.path.join(os.getenv("HOME"),'epa2015/utils'))

data_dictionary = sys.argv[1]
prefix = sys.argv[2]

def spaces_to_snake(column_name):
    
    """
    converts a string that has spaces into snake_case
    Example:
        print camel_to_snake("KENNY BROUGHT HIS WIFE")
        > KENNY_BROUGHT_HIS_WIFE
    To see how to apply this to camel case, see:
        http://stackoverflow.com/questions/1175208/elegant-python-function-to-convert-camelcase-to-camel-case
    """

    s = re.sub(r"\s+", '_', column_name)
    s = re.sub(r'/|-', '_', s)
    s = re.sub(r'\(|\)|\*','',s)
    
    return s.lower()    

data_dir = "/mnt/data/epa"
xl = pd.ExcelFile(data_dictionary)
names = xl.sheet_names

with open("create_table_" + prefix + ".sql", 'w') as f, open("drop_table_" + prefix + ".sql", 'w') as d, open('load_' + prefix + '_csv.sh', 'w') as c:
  
    c.write("#!/bin/bash -xv\n\n") 
    c.write("psql -f drop_table_" + prefix + ".sql\n")
    c.write("psql -f create_table_" + prefix + ".sql\n\n")

    for name in names:
    
        table = name.lower()
        f.write("--- " + table + "\n\n")
    
        df = xl.parse(name)

        df.columns = ['no.','start','column','type','length']
        df['column'] = df['column'].map(lambda x: unicodedata.normalize('NFKD', x).encode('ascii','ignore') if isinstance(x, unicode) else x)
        df['column'] = df['column'].map(lambda x: spaces_to_snake(x))

        schema = df.ix[:, ['column', 'start', 'length']]
        schema.to_csv(table + '_schema.csv', index = False, encoding = 'utf-8')

        db_string = ""    

        for k,v in zip(df['column'], df['type']):
            if v.lower().find('alphanumeric') == 0:
                db_string = db_string + k + " VARCHAR" + ",\n"
            elif v.lower().find('date') == 0:
                db_string = db_string + k + " DATE" + ",\n"
            elif v.lower().find('integer') == 0:
                db_string = db_string + k + " BIGINT" + ",\n"
            elif v.lower().find('num') == 0:
                db_string = db_string + k + " FLOAT" + ",\n"

        f.write("CREATE TABLE rcra." + table + "( \n" + db_string[:-2] + "\n);\n\n")
        d.write("DROP TABLE IF EXISTS rcra." + table + ";\n\n")
        
        c.write("echo loading " + table + " into the database ...\n")
        c.write("in2csv -e iso-8859-1 -f fixed -s " + table + "_schema.csv " + os.path.join(data_dir, "RCRA_flat_files", name.lower() + ".txt") + 
        " | psql -c '\\COPY rcra." + table + " FROM STDIN WITH CSV HEADER'\n")
        c.write("echo rcra." + table + " has been loaded into the database.\n\n")
        
