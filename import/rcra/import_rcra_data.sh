#!/bin/bash -xv

RCRA_DIR=$1

# Make the load scripts and SQL files
psql -f import/rcra/create_schema_rcra.sql
psql -f import/rcra/create_table_\*.sql

# Loop over the load scripts
for file in import/rcra/load*csv.sh; do
  bash $file $RCRA_DIR
done
