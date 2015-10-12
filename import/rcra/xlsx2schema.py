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

for name in names:
    
    table = name.lower()
    
    df = xl.parse(name)

    df.columns = ['no.','start','column','type','length']
    df['column'] = df['column'].map(lambda x: unicodedata.normalize('NFKD', x).encode('ascii','ignore') if isinstance(x, unicode) else x)
    df['column'] = df['column'].map(lambda x: spaces_to_snake(x))

    schema = df.ix[:, ['column', 'start', 'length']]
    schema.to_csv('mnt/data/epa/import/rcra/' + table + '_schema.csv', index = False, encoding = 'utf-8')
