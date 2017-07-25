#!/usr/bin/env python
# (python 2.7)

# Example usage:
#   python client_test.py https://google.com

import requests
from time import sleep
import sys

base_api_url = 'http://localhost:5000/api/v1/web-statuses?filter[url]='
remote_url = 'https://www.cia.gov/library/publications/the-world-factbook/rankorder/2127rank.html'

if len(sys.argv) < 2:
    print("WARNING => No URL argument passed")
else:
    remote_url = sys.argv[1]

for i in range(9):
    response_data = requests.get(base_api_url + remote_url).json()['data']
    if response_data:
        web_status_record = response_data[0]
        page_is_parsed = web_status_record['attributes']['is-parsed']
        if page_is_parsed:
            print("SUCCESS: The page was successfully parsed. You may now query its data.")
            # query data
            # ...
            break;
        else:
            print("STATUS: Parsing...")
            sleep(4)
