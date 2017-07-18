#!/usr/bin/env python
# (python 2.7)

# Example usage:
#   python client_test.py https://google.com

import requests
from time import sleep
import sys

base_api_url = 'http://localhost:5000/api/v1/web-statuses?filter[url]='
remote_url = 'http://statisticstimes.com/economy/countries-by-projected-gdp2.php'

if len(sys.argv) < 2:
    print("WARNING => No URL argument passed")
else:
    remote_url = sys.argv[1]

for i in range(9):
    response = requests.get(base_api_url + remote_url)
    print("RESPONSE => " + str(response.json()))
    sleep(1)
