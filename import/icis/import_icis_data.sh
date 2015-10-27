#!/bin/bash -xv

NPDES_DIR=$1
CASE_DIR=$2
AIR_DIR=$3

psql -f import/icis/create_table_icis.sql

echo loading NPDES_INSPECTIONS.csv from ECHO dashboard into the database ...
cat $NPDES_DIR/NPDES_INSPECTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_inspections FROM STDIN WITH CSV HEADER;'
echo NPDES_INSPECTIONS.csv has been loaded into the database as icis.npdes_inspections.

echo loading NPDES_CS_VIOLATIONS.csv from ECHO dashboard into the database ...
cat $NPDES_DIR/NPDES_CS_VIOLATIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_cs_violations FROM STDIN WITH CSV HEADER;'
echo NPDES_CS_VIOLATIONS.csv has been loaded into the database as icis.npdes_cs_violations.

echo loading NPDES_FORMAL_ENFORCEMENT_ACTIONS.csv into the database ...
cat $NPDES_DIR/NPDES_FORMAL_ENFORCEMENT_ACTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_formal_enforcement_actions FROM STDIN WITH CSV HEADER;'
echo NPDES_FORMAL_ENFORCEMENT_ACTIONS.csv has been loaded into the database as icis.npdes_formal_enforcement_actions.

echo loading NPDES_INFORMAL_ENFORCEMENT_ACTIONS.csv into the database ...
cat $NPDES_DIR/NPDES_INFORMAL_ENFORCEMENT_ACTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_informal_enforcement_actions FROM STDIN WITH CSV HEADER;'
echo NPDES_INFORMAL_ENFORCEMENT_ACTIONS.csv has been loaded into the database as icis.npdes_informal_enforcement_actions.

echo loading NPDES_NAICS.csv into the database ...
cat $NPDES_DIR/NPDES_NAICS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_naics FROM STDIN WITH CSV HEADER;'
echo NPDES_NAICS.csv has been loaded into the database as icis.npdes_naics.

echo loading NPDES_PS_VIOLATIONS.csv into the database ...
cat $NPDES_DIR/NPDES_PS_VIOLATIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_ps_violations FROM STDIN WITH CSV HEADER;'
echo NPDES_PS_VIOLATIONS.csv has been loaded into the database as icis.npdes_ps_violations.

echo loading NPDES_SE_VIOLATIONS.csv into the database ...
cat $NPDES_DIR/NPDES_SE_VIOLATIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY "icis_npdes_se_violations" FROM STDIN WITH CSV HEADER;'
echo NPDES_SE_VIOLATIONS.csv has been loaded into the database as icis.npdes_se_violations.

echo loading NPDES_QNCR_HISTORY.csv into the database ...
cat $NPDES_DIR/NPDES_QNCR_HISTORY.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_qncr_history FROM STDIN WITH CSV HEADER;'
echo NPDES_QNCR_HISTORY.csv has been loaded into the database as icis.npdes_qncr_history.

echo loading NPDES_SICS.csv into the database ...
cat $NPDES_DIR/NPDES_SICS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.npdes_sics FROM STDIN WITH CSV HEADER;'
echo NPDES_SICS.csv has been loaded into the database as icis.npdes_sics.

echo loading CASE_DEFENDANTS.csv into the database ...
cat $CASE_DIR/CASE_DEFENDANTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_defendants FROM STDIN WITH CSV HEADER;'
echo CASE_DEFENDANTS.csv has been loaded into the database as icis.fec_defendants.

echo loading CASE_ENFORCEMENTS.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcements FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENTS.csv has been loaded into the database as icis.fec_enforcements.

echo loading CASE_VIOLATIONS.csv into the database ...
cat $CASE_DIR/CASE_VIOLATIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_violations FROM STDIN WITH CSV HEADER;'
echo CASE_VIOLATIONS.csv has been loaded into the database as icis.fec_violations.

echo loading CASE_ENFORCEMENT_TYPE.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_TYPE.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_type FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_TYPE.csv has been loaded into the database as icis.fec_enforcement_type.

echo loading CASE_ENFORCEMENT_TYPE.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_TYPE.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_type FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_TYPE.csv has been loaded into the database as icis.fec_enforcement_type.

echo loading CASE_RELIEF_SOUGHT.csv into the database ...
cat $CASE_DIR/CASE_RELIEF_SOUGHT.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_relief_sought FROM STDIN WITH CSV HEADER;'
echo CASE_RELIEF_SOUGHT.csv has been loaded into the database as icis.fec_relief_sought.

echo loading CASE_PENALTIES.csv into the database ...
cat $CASE_DIR/CASE_PENALTIES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_penalties FROM STDIN WITH CSV HEADER;'
echo CASE_PENALTIES.csv has been loaded into the database as icis.fec_penalties.

echo loading CASE_LAW_SECTIONS.csv into the database ...
cat $CASE_DIR/CASE_LAW_SECTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_law_sections FROM STDIN WITH CSV HEADER;'
echo CASE_LAW_SECTIONS.csv has been loaded into the database as icis.fec_law_sections.


echo loading CASE_FACILITIES.csv into the database ...
cat $CASE_DIR/CASE_FACILITIES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_facilities FROM STDIN WITH CSV HEADER;'
echo CASE_FACILITIES.csv has been loaded into the database as icis.fec_facilities.

echo loading CASE_MILESTONES.csv into the database ...
cat $CASE_DIR/CASE_MILESTONES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_milestones FROM STDIN WITH CSV HEADER;'
echo CASE_MILESTONES.csv has been loaded into the database as icis.fec_milestones.

echo loading CASE_POLLUTANTS.csv into the database ...
cat $CASE_DIR/CASE_POLLUTANTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_pollutants FROM STDIN WITH CSV HEADER;'
echo CASE_POLLUTANTS.csv has been loaded into the database as icis.fec_pollutants.

echo loading CASE_ENFORCEMENT_CONCLUSIONS.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_CONCLUSIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_conclusions FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_CONCLUSIONS.csv has been loaded into the database as icis.fec_enforcement_conclusions.

echo loading CASE_ENFORCEMENT_CONCLUSION_POLLUTANTS.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_CONCLUSION_POLLUTANTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_conclusion_pollutants FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_CONCLUSION_POLLUTANTS.csv has been loaded into the database as icis.fec_enforcement_conclusion_pollutants.

echo loading CASE_ENFORCEMENT_CONCLUSION_COMPLYING_ACTIONS.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_CONCLUSION_COMPLYING_ACTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_conclusion_complying_actions FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_CONCLUSION_COMPLYING_ACTIONS.csv has been loaded into the database as icis.fec_enforcement_conclusion_complying_actions.

echo loading CASE_ENFORCEMENT_CONCLUSION_FACILITIES.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_CONCLUSION_FACILITIES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_conclusion_facilities FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_CONCLUSION_FACILITIES.csv has been loaded into the database as icis.fec_enforcement_conclusion_facilities.

echo loading CASE_ENFORCEMENT_CONCLUSION_SEP.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_CONCLUSION_SEP.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_conclusion_sep FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_CONCLUSION_SEP.csv has been loaded into the database as icis.fec_enforcement_conclusion_sep.

echo loading CASE_ENFORCEMENT_CONCLUSION_DOLLARS.csv into the database ...
cat $CASE_DIR/CASE_ENFORCEMENT_CONCLUSION_DOLLARS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_enforcement_conclusion_dollars FROM STDIN WITH CSV HEADER;'
echo CASE_ENFORCEMENT_CONCLUSION_DOLLARS.csv has been loaded into the database as icis.fec_enforcement_conclusion_dollars.

echo loading CASE_REGIONAL_DOCKETS.csv into the database ...
cat $CASE_DIR/CASE_REGIONAL_DOCKETS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_regional_dockets FROM STDIN WITH CSV HEADER;'
echo CASE_REGIONAL_DOCKETS.csv has been loaded into the database as icis.fec_regional_dockets.

echo loading CASE_RELATED_ACTIVITIES.csv into the database ...
cat $CASE_DIR/CASE_RELATED_ACTIVITIES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.fec_related_activities FROM STDIN WITH CSV HEADER;'
echo CASE_RELATED_ACTIVITIES.csv has been loaded into the database as icis.fec_related_activities.


echo loading ICIS-AIR_FACILITIES.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_FACILITIES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_facilities FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_FACILITIES.CSV has been loaded into the database as icis.air_facilities.

echo loading ICIS-AIR_PROGRAMS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_PROGRAMS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_programs FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_PROGRAMS.CSV has been loaded into the database as icis.air_programs.

echo loading ICIS-AIR_PROGRAM_SUBPARTS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_PROGRAM_SUBPARTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_program_subparts FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_PROGRAM_SUBPARTS.CSV has been loaded into the database as icis.air_program_subparts.

echo loading ICIS-AIR_POLLUTANTS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_POLLUTANTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_pollutants FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_POLLUTANTS.CSV has been loaded into the database as icis.air_pollutants.

echo loading ICIS-AIR_FCES_PCES.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_FCES_PCES.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_fces_pces FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_FCES_PCES.CSV has been loaded into the database as icis.air_fces_pces.

echo loading ICIS-AIR_STACK_TESTS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_STACK_TESTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_stack_tests FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_STACK_TESTS.CSV has been loaded into the database as icis.air_stack_tests.

echo loading ICIS-AIR_TITLEV_CERTS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_TITLEV_CERTS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_titlev_certs FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_TITLEV_CERTS.CSV has been loaded into the database as icis.air_titlev_certs.

echo loading ICIS-AIR_FORMAL_ACTIONS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_FORMAL_ACTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_formal_actions FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_FORMAL_ACTIONS.CSV has been loaded into the database as icis.air_formal_actions.

echo loading ICIS-AIR_INFORMAL_ACTIONS.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_INFORMAL_ACTIONS.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_informal_actions FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_INFORMAL_ACTIONS.CSV has been loaded into the database as icis.air_informal_actions.

echo loading ICIS-AIR_HPV_HISTORY.CSV into the database ...
cat $AIR_DIR/ICIS-AIR_HPV_HISTORY.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY icis.air_hpv_history FROM STDIN WITH CSV HEADER;'
echo ICIS-AIR_HPV_HISTORY.CSV has been loaded into the database as icis.air_hpv_history.

