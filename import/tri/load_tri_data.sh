#!/bin/bash -xv

TRI_DIR=$1

## Create TRI schema

psql -f import/tri/create_schema_tri.sql
psql -f import/tri/create_table_tri.sql


cat $TRI_DIR/tri.type_1.csv | psql -c '\COPY tri.type_1 FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_2a.csv | psql  -c '\COPY tri.type_2a FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_2b.csv | psql -c '\COPY tri.type_2b FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_3a.csv | psql -c '\COPY tri.type_3a FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_3b.csv | psql -c '\COPY tri.type_3b FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_4.csv | psql -c '\COPY tri.type_4 FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_5.csv | psql -c '\COPY tri.type_5 FROM STDIN WITH CSV HEADER;'

cat $TRI_DIR/tri.type_6.csv | psql -c '\COPY tri.type_6 FROM STDIN WITH CSV HEADER;'

