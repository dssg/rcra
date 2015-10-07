#!/bin/bash -xv

## Download TRI files 

for i in {1987..2013}; do
    wget -P $OUTPUT http://www3.epa.gov/tri/US_${i}_v13.zip 
done


## Unzip all the files

find $OUTPUT -name '*.zip' -exec unzip {} \;





