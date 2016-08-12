from google_query import *


def read_api_keys(FILEPATH):
    """ reads the list of API keys to validate from a file and returns the list
    of unique keys

    :param FILEPATH [string] Path to the file containing the list of API keys
    :return [list] A list of unique API keys
    :rtype: list
    :raises: googlemaps.exceptions.ApiError
    """
    api_keys = list() 
    with open(FILEPATH) as f:
        for line in f:
            api_key = line.strip()
            api_keys.append(api_key)

    return api_keys

sample_query = {
                "entidad_federativa": "MORELOS",
                "municipio": "CUERNAVACA",
                "localidad": "CUERNAVACA",
                "asen": "TRES MARIAS",
                "vial": "HIDALGO",
                "vial_1": "HIDALGO",
                "vial_2": "FRANCISCO CORTES"
               }

if __name__ == "__main__":
    api_keys_to_validate = read_api_keys("raw_Google_Maps_Geocoding_API_keys.csv")
    validated_api_keys = set()
    for api_key in api_keys_to_validate:
        print("Trying", api_key)
        try:
            geocode_res = query_location(sample_query, api_key)
        except googlemaps.exceptions.ApiError:
            print("Invalid key problem")
        else:
            validated_api_keys.add(api_key)
    with open("validated_API_keys", "w") as g:
        g.write("\n".join(validated_api_keys))
