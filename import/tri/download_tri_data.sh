#!/bin/bash -xv

## Download TRI files 

for i in {1987..2013}; do
    wget http://www3.epa.gov/tri/US_${i}_v13.zip 
done


## Unzip all the files

find . -name '*.zip' -exec unzip {} \;





