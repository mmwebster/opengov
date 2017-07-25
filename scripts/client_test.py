#!/usr/bin/env python
# (python 2.7)

# @brief Tests the entire user experience for the provided web page
# @example-usage
#   python client_test.py https://google.com

from urllib import urlencode
from time import sleep
import requests
import json
import sys


base_api_url = "http://localhost:5000/api/v1/"
web_status_endpoint = "web-statuses?filter[url]="
web_data_endpoint = "web-data?" # No param to make urlencode easier to
                                # work with
web_page_remote_url = "https://www.cia.gov/library/publications/t" + \
                        "he-world-factbook/rankorder/2127rank.html"
user_query_str = "SELECT country FROM '" + \
                  web_page_remote_url + \
                 "' WHERE rank == 5"

if len(sys.argv) < 2:
    print("WARNING: No URL argument passed for remote web page to scrape.")
else:
    remote_url = sys.argv[1]

query_completed = False

while not query_completed:
    # initiate scaping/parsing and/or check status
    response_data = requests.get( base_api_url +
                                  web_status_endpoint +
                                  web_page_remote_url ).json()['data']
    if response_data:
        web_status_record = response_data[0]
        page_is_parsed = web_status_record['attributes']['is-parsed']
        if page_is_parsed:
            print("SUCCESS: The page was successfully parsed. Now " + \
                  "querying its data.")
            # query data
            # encode for url param
            encoded_query_str = urlencode({ 'filter[query]': user_query_str })
            print("STATUS: Encoded query to => " + str(encoded_query_str))
            # make the GET request and store response
            response = requests.get( base_api_url +
                                     web_data_endpoint +
                                     encoded_query_str )
            # print out the JSON-API-spec'd response in a readable format
            if response.json()["data"]:
                print("STATUS: The following data matched this query.\n")
                for datum in response.json()["data"]:
                    print("\nDatum #" + datum["id"])
                    for key, value in datum["attributes"].iteritems():
                        print("      " + str(key) + " => " + str(value))
            else:
                print("STATUS: No data matched this query.\n")
            query_completed = True
        else:
            print("STATUS: Parsing...")
            sleep(4)
