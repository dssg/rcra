#!/bin/bash -xv

TRI_DIR=$1

## Create TRI schema

psql -f import/tri/create_schema_tri.sql
psql -f import/tri/create_table_tri.sql

# Create all the tables and Load the data

for i in 1 "2a" "2b" "3a" "3b" 4 5 6; 
do
    head -1 $TRI_DIR/US_${i}_1987_v13.txt > $TRI_DIR/tri_${i}.txt; tail -q -n +2 $TRI_DIR/US_${i}_*_v13.txt >> $TRI_DIR/tri_${i}.txt 
    in2csv -t -f csv -e iso-8859-1 $TRI_DIR/tri_${i}.txt > $TRI_DIR/tri.type_${i}.csv 

#    csvsql -i postgresql --no-constraints --table tri.${i} $TRI_DIR/tri_${i}.csv | perl -pe '$_= lc($_)' | perl -pe 's:"[^"]*":($x=$&)=~s/ /_/g;$x:ge' > import/tri/create_table_${i}.sql

#    psql -f import/tri/create_table_${i}.sql 1>/dev/null 2> import/tri/create_table_${i}.log
#    psql -c "\copy tri.type_${i} from stdin with csv header"
done


echo loading tri.type_1.csv into the database ...
cat $TRI_DIR/tri.type_1.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_1 FROM STDIN WITH CSV HEADER;'
echo tri.type_1.csv has been loaded into the database.


echo loading tri.type_2a.csv into the database ...
cat $TRI_DIR/tri.type_2a.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_2a FROM STDIN WITH CSV HEADER;'
echo tri.type_2a.csv has been loaded into the database.


echo loading tri.type_2b.csv into the database ...
cat $TRI_DIR/tri.type_2b.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_2b FROM STDIN WITH CSV HEADER;'
echo tri.type_2b.csv has been loaded into the database.

echo loading tri.type_3a.csv into the database ...
cat $TRI_DIR/tri.type_3a.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_3a FROM STDIN WITH CSV HEADER;'
echo tri.type_3a.csv has been loaded into the database.

echo loading tri.type_3b.csv into the database ...
cat $TRI_DIR/tri.type_3b.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_3b FROM STDIN WITH CSV HEADER;'
echo tri.type_3b.csv has been loaded into the database.

echo loading tri.type_4.csv into the database ...
cat $TRI_DIR/tri.type_4.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_4 FROM STDIN WITH CSV HEADER;'
echo tri.type_4.csv has been loaded into the database.

echo loading tri.type_5.csv into the database ...
cat $TRI_DIR/tri.type_5.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_5 FROM STDIN WITH CSV HEADER;'
echo tri.type_5.csv has been loaded into the database.

echo loading tri.type_6.csv into the database ...
cat $TRI_DIR/tri.type_6.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY tri.type_6 FROM STDIN WITH CSV HEADER;'
echo tri.type_6.csv has been loaded into the database.
