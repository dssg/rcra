# -*- coding: iso-8859-1 -*-
"""Query using Google geocoding API

This module includes functions for querying the google geocoding API
given Mexican locality and street intersection information. There are
essentially three components to geocoding,
   - Construct the geocoding constraints (e.g., 'must be in state x'),
     and the search string (e.g., 'intersection of u & w') given a
     geographic information.
   - Call the googlemaps module to retrieve results from this search.
   - Postprocess the output of this call to keep relevant information
     about the search parameters and results.
"""

import json
import time
import googlemaps
#import pandas as pd

def isnull(str_to_check):
    """ Checks if a field is NULL

    :param str_to_check [string]

    :return True if NULL, False if not NULL
    :rtype: boolean
    """
    if str_to_check is None or str_to_check == "NULL":
        return True
    return False


def clean_strs(strs):
    """ Strip single quotes from the search strs so that they are writable in
    the database
    
    :param strs [list of strings] search strings to clean

    :return cleaned list of strings
    :rtype [list of strings]
    """
    return [strng.replace("'","") for strng in strs]


def encode_null_strings(string_series, null_strings=None):
    """Given a Pandas Series, convert strings meaning nan to actual nan

    :param string_series [Pandas Series of strings] A Series
     containing strings, some of which we want to convert to NaN.
    :param null_strings [list of string] A list containing strings
     that should be converted to NA.

    :return x The original series of strings, with null_strings
    converted to NaN
    :rtype: Pandas Series of strings
    """
    if null_strings is None:
        null_strings = ["ninguna", "ninguno", "sin nombre", "nt", "0",
                        "sin informacion", "0000000", "sn"]

    nan_ix = [z in null_strings for z in string_series]
    string_series[nan_ix] = float("nan")
    return string_series


def erase_accents(word_series):
    """Remove accents from a pandas Series

    :param word_series [pandas Series] A series of strings possibly
    containing accents (which we want to remove).
    :return word_series [pandas Series] The original series, but with
    all the accents removed.
    :rtype pandas Series
    """
    subs = [('á', 'a'),
            ('é', 'e'),
            ('í', 'i'),
            ('ó', 'o'),
            ('ú', 'u'),
            ('ñ', 'n'),
            ('Á', 'A'),
            ('É', 'E'),
            ('Í', 'I'),
            ('Ó', 'O'),
            ('Ú', 'U'),
            ('Ñ', 'N')]
    for cur_sub in subs:
        word_series = word_series.str.replace(cur_sub[0], cur_sub[1])
    return word_series


def get_constraints(geo_info):
    """Get geocoding constraints from available geographic information

    :param geo_info [dict] A dictionary containing geographic
     information. Assumed to have keys called "entidad_federativa",
     "municipio", "localidad", "localidad", and "asen"
     corresponding to various levels of granularity in mexican
     addresses. The values associated with these keys are allowed to
     be NaN.

    :return A dictionary encoding the geographic information in a way
     that can be input as a "components" object in a call to
     gmaps.geocode() in the googlemaps library.
    :rtype dict
    """
    print("im in constraints!")
    return {"country": "USA"}


def get_street_info(street_info):
    """Get street information for a geographic location

    :param street_info [dict] A dictionary containing geographic
     information at the street level. Assumed to have keys called
     "num_ext", "vial", "vial_1", and "vial_2"; we will query addresses or
     intersections "vial & vial_1" and "vial & vial_2". The values associated
     with these keys are allowed to be null.

    :return search_str A dictionary giving search strings at the street and
     intersection level. "vial" gives a search string at the road level.
     "intersect" gives a list of search strings corresponding to "vial_1" and
     "vial_2", for each one of those 2 streets which is available.
    :rtype dict
    """

    search_str = {"street_number": street_info["street_number"], 
                    "street": street_info["street"],
                  "city": street_info["city"],
                  "state": street_info["state"],
                  "zipcode": street_info["zipcode"]
                  }
    return search_str


def get_search_strs(street_input, max_query_per_row=2):
    """Get a list of search strings, given constraints in the number of queries
    per address

    :param street_input [dict] A dictionary containing geographic
     information at the street level. Assumed to have keys called
     "vial", "vial_1", and "vial_2"; we will query intersections "vial
     & vial_1" and "vial & vial_2". The values associated with these
     keys are allowed to be null.
    :param max_query_per_row [int] The maximum number of search strings to
     return for the given address.

    :return search_str [list] A list of search strings for the given address.
     If intersections are available, these are returned, up to the maximum number
     of queries per row. If only road information is available (and not cross
     streets vial_1 and vial_2), then the result is the name of that road. If
     street information is not available, then the only list element is the empty
     string.
    :rtype list[string]
    """
    street_info = get_street_info(street_input)
    print("street_info", street_info)

    search_str = " ".join([x for x in street_info.values() if x])
    print("This is", search_str)
    return search_str


def postprocess_geocode(geo):
    """Postprocess the output of a google geocoding query

    :param geo [list of dict] The list of dictionaries resulting from a call
     to gmaps.geocode() in the googlemaps library.

    :return [dict] A dictionary of simplified output from geo. Only
     information from the first search hit is returned. The output fields are
       geo_names [dict] A dictionary giving the names of geographic units
       containing the returned latitude and longitude.
       pos [dict] A dictionary giving the geocoded latitude and longitude.
       quality [dict] A summary of geocoding quality information. This
       specifies whether the hit had an approximate location, was a partial
       string match, and how many geocoding hits the API returned.
    :rtype: dict
    """
    # only use the top geocoding hit
    if len(geo) == 0:
        return {"n_hits": float(0), 
                "match_type": None,
                "location_type": {"lat": None, "lng": None},
                "types": None}

    address = geo[0]["address_components"]
    granularity = [g["types"][0] for g in address]
    names = [g["long_name"] for g in address]

    geo_names = dict(zip(granularity, names))
    pos = geo[0]["geometry"]["location"]

    # quality assessments
    if "partial_match" in geo[0].keys():
        match_type = geo[0]["partial_match"]
    else:
        match_type = False

    quality = {"n_hits": len(geo),
               "partial_match": match_type,
               "location_type": geo[0]["geometry"]["location_type"],
               "types": geo[0]["types"]}

    return {"geo_names": geo_names, "pos": pos, "quality": quality}


def query_location(geo, api_key, max_query_per_row=2):
    """Return geocoding results for a single location

    :param geo [dict] A dictionary containing geographic information. Assumed to
     have keys called "id", "entidad_federativa", "municipio", "localidad",
     "localidad", and "asen", corresponding to a search id and various levels
     of granularity in mexican addresses, as well as "vial", "vial_1", and
     "vial_2", giving the names of the main road ("vial") and side streets
     ("vial_1" and "vial_2"). The values associated with these keys are allowed
     to be NaN.
    :param api_key [string] A google maps API key, to use when querying google
     maps.
    :param max_query_per_row [int] The maximum number of api calls to max for
     the given address.

    :return [dict] A dictionary describing the input and results to the API
     call. The geocoding input is in the "query_input" field. Within
     this dictionary, constraints are in the "constraints" key, the
     actual search string used is in the "search" field, and the
     postprocessed query results are in
     "query_results". "query_results" is a list whose elements are the
     postprocessed output for each query made at the address; see
     postprocess_geocode() for details on the fields contained here.
    :rtype: [dict]
    """
    gmap = googlemaps.Client(key=api_key, retry_timeout=10)
    constraints = get_constraints(geo)
    search_strs = get_search_strs(geo, max_query_per_row)

    query_results = []
    for search in search_strs:
        try:
            cur_result = gmap.geocode(search, constraints)
        except googlemaps.exceptions.ApiError as api_error:
            raise api_error
        except googlemaps.exceptions._RetriableRequest as retriable_request:
            raise retriable_request 
        except googlemaps.exceptions.Timeout as timeout_error:
            raise timeout_error
        except googlemaps.exceptions.TransportError as transport_error:
            raise transport_error
        else:
            query_results += [postprocess_geocode(cur_result)]

    return {"query_input": {"id": geo["id"],
                            "constraints": constraints,
                            "search": clean_strs(search_strs)},
            "query_results": query_results}


def query_locations_df(geo_data, api_key, output_path, max_query_per_row=1):
    """Wrapper for query_location() that queries every row in a Pandas DataFrame

    :param geo_data [DataFrame] A pandas data frame with the following
     column indices,
       - entidad_federativa The name of the state for each row.
       - municipio The name of the municipality for each row.
       - localidad The name of the localidad for each row.
       - asen The name of the asenmiento for each row.
       - vial The name of the street for each row.
       - vial_1 The first side street for each row.
       - vial_2 The second side street for each row.
       - vial_3 The back street for each row.
    :param api_key [string] A google maps API key, to use when
     querying google maps.
    :param output_path [string] A path and filename to which to write
    the results of the querying.
    :param max_query_per_row [int] The maximum number of api calls to max for
     the given address.

    :return None
    :rtype None
    :side-effects Writes the querying results into the output_path
    file. Each line can be read in as a JSON object.

    :example

    #     Suppose geo_data is a pandas DataFrame with first few rows like this
    #
    #             vial   asen         vial_1     vial_2 vial_pos  \
    # 1            NaN  40883            NaN        NaN      NaN
    # 2  cda de trebol  52924   cda de cobre  cda jaral      NaN
    # 4   privlibertad  47540  benito juarez        NaN      NaN
    # 6            NaN  55347            NaN        NaN      NaN
    #
    #                               localidad entidad_federativa  \
    # 1        san jose ixtapa (barrio viejo)           guerrero
    # 2                   ciudad lopez mateos             mexico
    # 4  matancillas (san isidro matancillas)            jalisco
    # 6                   ecatepec de morelos             mexico
    #
    #                municipio
    # 1  zihuatanejo de azueta
    # 2   atizapan de zaragoza
    # 4     ojuelos de jalisco
    # 6    ecatepec de morelos
    #
    # api is a dictionary like this {'GOOGLE_MAPS_KEY': 'key from https://developers.google.com/maps'}
    # and output_path is a path like "~/Desktop/output.txt". Then, the
    # function can be called like,

    query_locations_df(geo_data, api["GOOGLE_MAPS_KEY"], output_path,
                       max_query_per_row=1)
    """
    time_start = time.time()
    with open(output_path, "w") as outfile:
        for row_ix, row in geo_data.iterrows():
            if row_ix % 10 == 0:
                print("querying row %d" % row_ix)
            query_result = query_location(row, api_key, max_query_per_row)
            json.dump(query_result, outfile)
            outfile.write("\n")
    time_end = time.time()
    print("%f minutes elapsed" % ((time_end - time_start) / 60))
