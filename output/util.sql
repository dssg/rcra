-- make_date is not available on postgresql < 9.4
CREATE OR REPLACE FUNCTION make_date(int, int, int) RETURNS date AS
E'SELECT (($1::text) || \'-\' || ($2::text) || \'-\' || ($3::text))::date;' LANGUAGE SQL;

CREATE OR REPLACE FUNCTION date_floor(date, int, int) RETURNS date AS
E'SELECT (make_date(extract(year from $1)::int, $2, $3) - (make_date(extract(year from $1)::int, $2, $3) > $1)::int * interval \'1 year\')::date' LANGUAGE SQL;

CREATE OR REPLACE FUNCTION date_ceil(date, int, int) RETURNS date AS
E'SELECT (make_date(extract(year from $1)::int, $2, $3) + (make_date(extract(year from $1)::int, $2, $3) < $1)::int * interval \'1 year\')::date' LANGUAGE SQL;
