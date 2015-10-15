#!/bin/bash -xv

RCRA_DIR=$1

# Make the load scripts and SQL files
psql -f import/rcra/create_schema_rcra.sql
psql -f import/rcra/create_table_A.sql
psql -f import/rcra/create_table_C.sql
psql -f import/rcra/create_table_F.sql
psql -f import/rcra/create_table_P.sql
psql -f import/rcra/create_table_H.sql
psql -f import/rcra/create_table_BR.sql
psql -f import/rcra/create_table_gis.sql

# Loop over the load scripts
for file in import/rcra/load*csv.sh; do
  bash $file $RCRA_DIR
done
