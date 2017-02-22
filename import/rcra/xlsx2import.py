import pandas as pd
import re, unicodedata, os, sys

data_dictionary = sys.argv[1]
output_dir = sys.argv[2]

def column_to_snake(column_name):
   
    """
    converts a string that has spaces into snake_case, truncates names, and removes digits
    to make strings acceptable PostgreSQL column names
    """

    s = re.sub(r"\s+", '_', column_name)
    s = re.sub(r'/|-', '_', s)
    s = re.sub(r'\(|\)|\*','',s)
    s = re.sub('^\d+', '', s)
    s = s[:60]

    return s.lower()    

xl = pd.ExcelFile(data_dictionary)
names = xl.sheet_names

for name in names:

    table = name.lower()

    df = xl.parse(name)

    df.columns = ['no.','start','column','type','length']
    df['column'] = df['column'].map(lambda x: unicodedata.normalize('NFKD', x).encode('ascii','ignore') if isinstance(x, unicode) else x)
    df['column'] = df['column'].map(lambda x: column_to_snake(x))

    schema = df.ix[:, ['column', 'start', 'length']]
    schema.to_csv(output_dir + '/schema/' + table + '.csv', index = False, encoding = 'utf-8')

    db_string = ""    

    with open(output_dir + '/create/' + table + '.sql', 'w') as f: 
        f.write("--- " + table + "\n\n")
        for k,v in zip(df['column'], df['type']):
            if v.lower().find('alphanumeric') == 0:
                db_string = db_string + k + " VARCHAR" + ",\n"
            elif v.lower().find('date') == 0:
                db_string = db_string + k + " DATE" + ",\n"
            elif v.lower().find('integer') == 0:
                db_string = db_string + k + " BIGINT" + ",\n"
            elif v.lower().find('num') == 0:
                db_string = db_string + k + " FLOAT" + ",\n"   
        
        f.write("DROP TABLE IF EXISTS rcra." + table + "; \n") 
        f.write("CREATE TABLE rcra." + table + "( \n" + db_string[:-2] + "\n);\n\n")
     
