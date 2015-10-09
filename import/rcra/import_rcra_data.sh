#!/bin/bash -xv

# Make the load scripts and SQL files
psql -f import/rcra/create_schema_rcra.sql
bash import/rcra/make_load_scripts.sh

#psql -f import/rcra/create_table_A.sql
#psql -f import/rcra/create_table_BR.sql
#psql -f import/rcra/create_table_C.sql
#psql -f import/rcra/create_table_F.sql
#psql -f import/rcra/create_table_gis.sql
#psql -f import/rcra/create_table_H.sql
#psql -f import/rcra/create_table_P.sql

#bash load_A_csv.sh
#bash load_BR_csv.sh
#bash load_C_csv.sh
#bash load_F_csv.sh
#bash load_gis_csv.sh
#bash load_H_csv.sh
#bash load_P_csv.sh

# Loop over the load scripts
#for file in import/rcra/load*csv.sh; do
#  bash $file
#done
