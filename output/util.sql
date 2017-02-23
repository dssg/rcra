DROP FUNCTION IF EXISTS anyarray_agg_statefunc(anyarray, anyarray) CASCADE;
CREATE FUNCTION anyarray_agg_statefunc(state anyarray, value anyarray)
    RETURNS anyarray AS
$$
    SELECT array_cat($1, $2)
$$
    LANGUAGE sql IMMUTABLE;
COMMENT ON FUNCTION anyarray_agg_statefunc(anyarray, anyarray) IS '
Used internally by aggregate anyarray_agg(anyarray).
';

DROP AGGREGATE IF EXISTS anyarray_agg(anyarray) CASCADE;
CREATE AGGREGATE anyarray_agg(anyarray) (
    SFUNC = anyarray_agg_statefunc,
    STYPE = anyarray
);
COMMENT ON AGGREGATE anyarray_agg(anyarray) IS '
Concatenates arrays into a single array when aggregating.
';

DROP FUNCTION IF EXISTS anyarray_uniq(anyarray);
CREATE OR REPLACE FUNCTION anyarray_uniq(with_array anyarray)
    RETURNS anyarray AS
$$
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
            IF with_array[loop_offset] IS NULL THEN
                IF NOT EXISTS(
                    SELECT 1 
                    FROM UNNEST(return_array) AS s(a)
                    WHERE a IS NULL
                ) THEN
                    return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
                END IF;
            -- When an array contains a NULL value, ANY() returns NULL instead of FALSE...
            ELSEIF NOT(with_array[loop_offset] = ANY(return_array)) OR NOT(NULL IS DISTINCT FROM (with_array[loop_offset] = ANY(return_array))) THEN
                return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
            END IF;
        END LOOP;

    RETURN return_array;
 END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION date_floor(date, int, int) RETURNS date AS
E'SELECT (make_date(extract(year from $1)::int, $2, $3) - (make_date(extract(year from $1)::int, $2, $3) > $1)::int * interval \'1 year\')::date' LANGUAGE SQL;

CREATE OR REPLACE FUNCTION date_ceil(date, int, int) RETURNS date AS
E'SELECT (make_date(extract(year from $1)::int, $2, $3) + (make_date(extract(year from $1)::int, $2, $3) < $1)::int * interval \'1 year\')::date' LANGUAGE SQL;

