#!/bin/bash -xv

# Make the load scripts and SQL files
psql -f import/rcra/create_schema_rcra.sql
bash import/rcra/make_load_scripts.sh

# Loop over the load scripts
for file in import/rcra/load*csv.sh; do
  bash $file
done
