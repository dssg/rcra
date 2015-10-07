#!/bin/bash -xv

# Make the load scripts and SQL files
psql -f create_schema_rcra.sql
bash make_load_scripts.sh

# Loop over the load scripts
for file in load*csv.sh; do
  bash $file
done
