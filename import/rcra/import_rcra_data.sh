#!/bin/bash -xv

RCRA_DIR=$1
LOAD_SCRIPTS=$2

# Make the load scripts and SQL files
psql -f $LOAD_SCRIPTS/create_schema_rcra.sql
psql -f $LOAD_SCRIPTS/create_table_A.sql
psql -f $LOAD_SCRIPTS/create_table_C.sql
psql -f $LOAD_SCRIPTS/create_table_F.sql
psql -f $LOAD_SCRIPTS/create_table_P.sql
psql -f $LOAD_SCRIPTS/create_table_H.sql
psql -f $LOAD_SCRIPTS/create_table_BR.sql
psql -f $LOAD_SCRIPTS/create_table_gis.sql

# Loop over the load scripts
for file in $LOAD_SCRIPTS/load*csv.sh; do
  chmod 755 $file
  bash $file $RCRA_DIR
done
