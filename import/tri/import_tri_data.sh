#!/bin/bash -xv

TRI_DIR=$1

## Create TRI schema

psql -f import/tri/create_schema_tri.sql

# Create all the tables and Load the data

for i in 1 "2a" "2b" "3a" "3b" 4 5 6; do
    head -1 $TRI_DIR/US_${i}_1987_v13.txt > $TRI_DIR/tri_${i}.txt; tail -q -n +2 $TRI_DIR/US_${i}_*_v13.txt >> $TRI_DIR/tri_{i}.txt 
    in2csv -t -f csv -e iso-8859-1 $TRI_DIR/tri_${i}.txt > $TRI_DIR/tri_${i}.csv 

    csvsql -i postgresql --no-constraints --table tri.${i} $TRI_DIR/tri_${i}.csv | perl -pe '$_= lc($_)' | perl -pe 's:"[^"]*":($x=$&)=~s/ /_/g;$x:ge' > import/tri/create_table_${i}.sql

    psql -f import/tri/create_table_${i}.sql 1>/dev/null 2> import/tri/create_table_${i}.log
    psql -c "\copy tri.${i} from stdin with csv header"
done
