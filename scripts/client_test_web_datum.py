#!/usr/bin/env python
# (python 2.7)

# Example usage:
#   python client_test_web_datum.py

import requests
from time import sleep
import sys
import json
from urllib import urlencode

try:
    from _my_web_datum_query import *
except:
    print("ERROR => no _my_web_datum_query.py file present (use the example format below in the code)");
    exit()

# Postgresql query syntax:
#
# [ WITH [ RECURSIVE ] with_query [, ...] ]
# SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
#     * | expression [ [ AS ] output_name ] [, ...]
#     [ FROM from_item [, ...] ]
#     [ WHERE condition ]
#     [ GROUP BY expression [, ...] ]
#     [ HAVING condition [, ...] ]
#     [ WINDOW window_name AS ( window_definition ) [, ...] ]
#     [ { UNION | INTERSECT | EXCEPT } [ ALL ] select ]
#     [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
#     [ LIMIT { count | ALL } ]
#     [ OFFSET start [ ROW | ROWS ] ]
#     [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
#     [ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]
#
# where from_item can be one of:
#
#     [ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
#     ( select ) [ AS ] alias [ ( column_alias [, ...] ) ]
#     with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
#     function_name ( [ argument [, ...] ] ) [ AS ] alias [ ( column_alias [, ...] | column_definition [, ...] ) ]
#     function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )
#     from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
#
# and with_query is:
#
#     with_query_name [ ( column_name [, ...] ) ] AS ( select )
#
# TABLE { [ ONLY ] table_name [ * ] | with_query_name }

def main():
    try:
        query_str
    except NameError:
        # import of query str failed
        print("ERROR => Query string improperly defined in _my_web_datum_query");
        exit()
    else:
        # import of query str succeeded
        encoded_query_str = urlencode({ 'filter[query]': query_str }) # encode
        print("Encoded Query => " + str(encoded_query_str))

        base_api_url = 'http://localhost:5000/api/v1/web-data?'

        response = requests.get(base_api_url + encoded_query_str)
        print("RESPONSE => " + str(response.json()))

        if response.json()["data"]:
            for datum in response.json()["data"]:
                print("\nDatum #" + datum["id"])
                for key, value in datum["attributes"].iteritems():
                    print("      " + str(key) + " => " + str(value))
        else:
            print("(No response data)\n")

        print("\n")

main()
