import os
import sys

create_scripts = os.listdir(sys.argv[1])
tables = [c[:-4] for c in create_scripts]

prefix_subdirs = {
    'b': 'biennial_report',
    'c': 'cme',
    'f': 'financial_assurance',
    'gis': 'gis',
    'h': 'handler',
    'lu': 'lookup_files',
}

def get_subdir(table):
    for prefix, subdir in prefix_subdirs.items():
        if table.startswith(prefix):
            return subdir
    else:
        raise ValueError("Unknown table: %s" % table)

for table in tables:
    if table in ('lu_naics', 'lu_other_permit'):
        # these tables no longer exist
        continue
    elif table in ('howner_operator', 'hcertification', 'fcost_estimate', 'fmechanism_detail'):
        # these tables have datatype import errors
        continue

    subdir = get_subdir(table)
    # ccitation file is currently misnamed
    filename = table
    if table == 'ccitation':
        filename = 'cctiation'

    # download and unzip data
    print(
"""
$[DATA_DIR]/import/rcra/download/{subdir}/{table}.txt <- [-timecheck]
    OUTPUTDIR=$(dirname $OUTPUT)
    mkdir -p $OUTPUTDIR
    wget -N -P $OUTPUTDIR ftp://ftp.epa.gov/rcrainfodata/rcra_flatfiles/{subdir}/{filename}.txt.gz
    gunzip -f $OUTPUTDIR/{filename}.txt.gz
""".format(subdir=subdir, table=table, filename=filename))
    if table == 'ccitation':
        # correct cctiation misspelling
        print "    mv $OUTPUTDIR/{filename}.txt $OUTPUT".format(filename=filename)

    # in2csv
    print(
"""
$[DATA_DIR]/import/rcra/csv/{subdir}/{table}.csv <- $[DATA_DIR]/import/rcra/download/{subdir}/{table}.txt, import/rcra/generated/
    # use iconv replace non-ascii chars
    mkdir -p $(dirname $OUTPUT)
    iconv -f ISO-8859-1 -t ascii//TRANSLIT $INPUT0 | in2csv -v -e ascii -f fixed -s $INPUT1/schema/{table}.csv > $OUTPUT || exit 1""".format(subdir=subdir, table=table))
    # TODO: import as text then clean and cast
    if table == 'cmecomp3':
        # remove a couple lines with invalid dates
        print "    sed -i '/,\(0051207\|26226\|18340\|(CASE CL\),/d' $OUTPUT"
    elif table == 'br_reporting':
        # remove a couple lines with invalid numbers
        print "    sed -i '/,NN0,/d; /,YN./d' $OUTPUT"

    # drop create table and copy
    print(
"""
$[SQL_DIR]/rcra/{table} <- import/rcra/generated/, $[DATA_DIR]/import/rcra/csv/{subdir}/{table}.csv
    psql -v ON_ERROR_STOP=1 -c "DROP TABLE IF EXISTS rcra.{table};" || exit 1
    psql -v ON_ERROR_STOP=1 -f $INPUT0/create/{table}.sql || exit 1
    tr -d '(\\r|\\000)' < $INPUT1 | psql -v ON_ERROR_STOP=1 -c "\\COPY rcra.{table} FROM STDIN WITH CSV HEADER" && touch $OUTPUT
""".format(subdir=subdir, table=table))
