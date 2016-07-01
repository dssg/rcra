#!/bin/bash 

TRI_DIR=$1
i=$2

echo "concatenating"
# get column names 
head -1 $TRI_DIR/US_${i}_1987_v14.txt > $TRI_DIR/tri_${i}.txt
# concatenate text files
tail -q -n +2 $TRI_DIR/US_${i}_*_v14.txt >> $TRI_DIR/tri_${i}.txt

echo "removing columns"
# remove last two columns
ncols=`head -1 $TRI_DIR/tri_${i}.txt | awk -F '\t' '{print NF}'` 
mv $TRI_DIR/tri_${i}.txt $TRI_DIR/tri_${i}.tmp
cut -f 1-$[$ncols-2] <$TRI_DIR/tri_${i}.tmp >$TRI_DIR/tri_${i}.txt &&
rm $TRI_DIR/tri_${i}.tmp  

# copy into database
psql -v ON_ERROR_STOP=1 -f import/tri/create_table_${i}.sql  

if [ "$i" = 1 ]; then
    echo "preprocessing tri_1.txt"
    sed -i '1661520,1661530s/BOYLE\t\t/BOYLE\t/;1661520,1661530s/COM\t\t$/COM\t\t\t/g' $TRI_DIR/tri_${i}.txt
fi

echo "importing"
cat $TRI_DIR/tri_${i}.txt | uconv -f iso-8859-1 -t utf-8 | awk 'BEGIN {FS=IFS=OFS="\t"} { for (N=1; N<NF;N++) sub(/NA/, "", $N)} 1' | psql -v ON_ERROR_STOP=1 -c "\COPY tri.type_${i} FROM STDIN WITH CSV HEADER QUOTE E'\b' DELIMITER AS E'\t'"


