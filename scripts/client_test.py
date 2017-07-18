#!/usr/bin/env python
# (python 2.7)

import requests
from time import sleep
import sys

url = 'http://localhost:5000/api/v1/web-statuses?filter[url]=ahttp://' \
      'statisticstimes.com/economy/countries-by-projected-gdp2.php'

if len(sys.argv) < 2:
    print("WARNING => No URL argument passed")
else:
    url = sys.argv[1]

for i in range(9):
    response = requests.get(url)
    print("RESPONSE => " + str(response.json()))
    sleep(1)
