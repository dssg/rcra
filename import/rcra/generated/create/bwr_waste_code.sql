--- bwr_waste_code

DROP TABLE IF EXISTS rcra.bwr_waste_code; 
CREATE TABLE rcra.bwr_waste_code( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number BIGINT,
hazardous_waste_sub_page_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

