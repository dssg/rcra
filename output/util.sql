-- these must be dropped in the right order to avoid dependency issues
DROP AGGREGATE IF EXISTS anyarray_agg(anyarray);
DROP FUNCTION IF EXISTS anyarray_agg_statefunc(anyarray, anyarray);
DROP FUNCTION IF EXISTS anyarray_uniq(anyarray);

-- make_date is not available on postgresql < 9.4
CREATE OR REPLACE FUNCTION make_date(int, int, int) RETURNS date AS
E'SELECT (($1::text) || \'-\' || ($2::text) || \'-\' || ($3::text))::date;' LANGUAGE SQL;

CREATE OR REPLACE FUNCTION date_floor(date, int, int) RETURNS date AS
E'SELECT (make_date(extract(year from $1)::int, $2, $3) - (make_date(extract(year from $1)::int, $2, $3) > $1)::int * interval \'1 year\')::date' LANGUAGE SQL;

CREATE OR REPLACE FUNCTION date_ceil(date, int, int) RETURNS date AS
E'SELECT (make_date(extract(year from $1)::int, $2, $3) + (make_date(extract(year from $1)::int, $2, $3) < $1)::int * interval \'1 year\')::date' LANGUAGE SQL;

CREATE FUNCTION anyarray_agg_statefunc(state anyarray, value anyarray)
    RETURNS anyarray AS
$BODY$
    SELECT array_cat($1, $2)
$BODY$
    LANGUAGE sql IMMUTABLE;
COMMENT ON FUNCTION anyarray_agg_statefunc(anyarray, anyarray) IS '
Used internally by aggregate anyarray_agg(anyarray).
';

CREATE AGGREGATE anyarray_agg(anyarray) (
    SFUNC = anyarray_agg_statefunc,
    STYPE = anyarray
);
COMMENT ON AGGREGATE anyarray_agg(anyarray) IS '
Concatenates arrays into a single array when aggregating.
';

CREATE OR REPLACE FUNCTION anyarray_uniq(with_array anyarray)
    RETURNS anyarray AS
$BODY$
    DECLARE
        -- The variable used to track iteration over "with_array".
        loop_offset integer;

        -- The array to be returned by this function.
        return_array with_array%TYPE := '{}';
    BEGIN
        IF with_array IS NULL THEN
            return NULL;
        END IF;
        
        IF with_array = '{}' THEN
            return return_array;
        END IF; 

        -- Iterate over each element in "concat_array".
        FOR loop_offset IN ARRAY_LOWER(with_array, 1)..ARRAY_UPPER(with_array, 1) LOOP
            IF NOT with_array[loop_offset] = ANY(return_array) THEN
                return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
            END IF;
        END LOOP;

    RETURN return_array;
 END;
$BODY$ LANGUAGE plpgsql;
