#!/bin/bash 

TRI_DIR=$1
i=$2

# get column names 
head -1 $TRI_DIR/US_${i}_1987_v13.txt > $TRI_DIR/tri_${i}.txt
# concatenate text files
tail -q -n +2 $TRI_DIR/US_${i}_*_v13.txt >> $TRI_DIR/tri_${i}.txt

# remove last two columns
ncols=`head -1 $TRI_DIR/tri_${i}.txt | awk -F '\t' '{print NF}'` 
mv $TRI_DIR/tri_${i}.txt $TRI_DIR/tri_${i}.tmp
cut -f 1-$[$ncols-2] <$TRI_DIR/tri_${i}.tmp >$TRI_DIR/tri_${i}.txt &&
rm $TRI_DIR/tri_${i}.tmp  

# convert to csv
in2csv -t -f csv -e iso-8859-1 $TRI_DIR/tri_${i}.txt > $TRI_DIR/tri_${i}.csv

# copy into database
psql -v ON_ERROR_STOP=1 -f import/tri/create_table_${i}.sql  
tr -d '(\r|\000)' < $TRI_DIR/tri_${i}.csv | psql -v ON_ERROR_STOP=1 -c '\'"COPY tri.type_${i} FROM STDIN WITH CSV HEADER;"



