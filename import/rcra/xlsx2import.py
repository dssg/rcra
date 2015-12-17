import pandas as pd
import re, unicodedata, os, sys

data_dictionary = sys.argv[1]
output_dir = sys.argv[2]

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

xl = pd.ExcelFile(data_dictionary)
names = xl.sheet_names

os.chdir(output_dir)

with open("create_table_rcra.sql", 'a') as f:

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

        for k in df['column']:
           db_string = db_string + k + " VARCHAR" + ",\n"
   
        f.write("DROP TABLE IF EXISTS rcra." + table + "; \n") 
        f.write("CREATE TABLE rcra." + table + "( \n" + db_string[:-2] + "\n);\n\n")
     
