DROP TABLE IF EXISTS output.region_crosswalk;

CREATE TABLE output.region_crosswalk(
state VARCHAR, 
epa_region VARCHAR
);

INSERT INTO region_crosswalk
VALUES ('MA','1'), ('ME','1'), ('CT','1'),('RI','1'),('NH','1'),
('NY','2'), ('NJ','2'), ('PR','2'), ('VI','2'),
('PA','3'),('MD','3'),('DC','3'),('VA','3'),('WV','3'),('DE','3'),
('KY','4'),('TN','4'),('NC','4'),('SC','4'),('GA','4'),('AL','4'),('MS','4'),('FL','4'),
('MN','5'), ('WI','5'),('MI','5'),('IL','5'),('IN','5'),('OH','5'),
('NM','6'), ('TX','6'),('OK','6'),('LA','6'),('AR','6'),
('NE','7'),('IA','7'),('KS','7'),('MO','7'),
('MT','8'),('WY','8'),('ND','8'),('SD','8'),('UT','8'),('CO','8'),
('CA','9'),('NV','9'),('AZ','9'),('HI','9'),('GU','9'),
('WA','10'),('OR','10'),('ID','10'),('AK','10');
