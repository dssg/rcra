#!/bin/sh

psql -v ON_ERROR_STOP=1 -c "DROP TABLE IF EXISTS rcra.facilities;

CREATE TABLE rcra.facilities (id_number text, facility_name text, activity_location text, full_enforcement text, hreport_universe_record text, street_address text, city_name text, state_code text, zip_code text, latitude83 decimal, longitude83 text, fed_waste_generator text, transporter text, active_site text, operating_tsdf text);
" && psql -v ON_ERROR_STOP=1 -c "\COPY rcra.facilities FROM $1 WITH CSV HEADER;" && psql -v ON_ERROR_STOP=1 -c "CREATE INDEX ON rcra.facilities (id_number);"
