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
import pandas as pd

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
    gmap = googlemaps.Client(key=api_key)
    constraints = get_constraints(geo)
    search_strs = get_search_strs(geo, max_query_per_row)

    query_results = []
    for search in search_strs:
        cur_result = gmap.geocode(search, constraints)
        query_results += [postprocess_geocode(cur_result)]

    return {"query_input": {"id": geo["id"],
                            "constraints": constraints,
                            "search": search_strs},
            "query_results": query_results}
