#!/bin/bash -xv

TRI_DIR=$1

## Create TRI schema

psql -f import/tri/create_schema_tri.sql
psql -f import/tri/create_table_tri.sql

echo loading tri.type_1.csv into the database ...
cat $TRI_DIR/tri.type_1.csv | psql -c '\COPY tri.type_1 FROM STDIN WITH CSV HEADER;'
echo tri.type_1.csv has been loaded into the database.


echo loading tri.type_2a.csv into the database ...
cat $TRI_DIR/tri.type_2a.csv | psql  -c '\COPY tri.type_2a FROM STDIN WITH CSV HEADER;'
echo tri.type_2a.csv has been loaded into the database.


echo loading tri.type_2b.csv into the database ...
cat $TRI_DIR/tri.type_2b.csv | psql -c '\COPY tri.type_2b FROM STDIN WITH CSV HEADER;'
echo tri.type_2b.csv has been loaded into the database.

echo loading tri.type_3a.csv into the database ...
cat $TRI_DIR/tri.type_3a.csv | psql -c '\COPY tri.type_3a FROM STDIN WITH CSV HEADER;'
echo tri.type_3a.csv has been loaded into the database.

echo loading tri.type_3b.csv into the database ...
cat $TRI_DIR/tri.type_3b.csv | psql -c '\COPY tri.type_3b FROM STDIN WITH CSV HEADER;'
echo tri.type_3b.csv has been loaded into the database.

echo loading tri.type_4.csv into the database ...
cat $TRI_DIR/tri.type_4.csv | psql -c '\COPY tri.type_4 FROM STDIN WITH CSV HEADER;'
echo tri.type_4.csv has been loaded into the database.

echo loading tri.type_5.csv into the database ...
cat $TRI_DIR/tri.type_5.csv | psql -c '\COPY tri.type_5 FROM STDIN WITH CSV HEADER;'
echo tri.type_5.csv has been loaded into the database.

echo loading tri.type_6.csv into the database ...
cat $TRI_DIR/tri.type_6.csv | psql -c '\COPY tri.type_6 FROM STDIN WITH CSV HEADER;'
echo tri.type_6.csv has been loaded into the database.
