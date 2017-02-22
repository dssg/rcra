--- huniversal_waste

DROP TABLE IF EXISTS rcra.huniversal_waste; 
CREATE TABLE rcra.huniversal_waste( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
universal_waste_type_owner VARCHAR,
universal_waste_type VARCHAR,
accumulated VARCHAR,
generated VARCHAR
);

