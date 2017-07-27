# OpenGov — WebStatuses API Module Unit Testing
## 27 July 2017

## Module Description
The WebStatuses module consists of all submodules servicing functionality of of the /api/v1/web-statuses?filter[url]=<url> API endpoint. This includes the return of a WebStatus record with a is-parsed field indicating the parsing status of the particular web page and initiation of parsing via the first call to this endpoint for a specific url (queues a job for the parsing/scraping worker).

## Equivalence Classes & Corresponding Unit Tests
1. Web page scraping/parsing has not yet begin
    * Desc: a user requests a web status record with the url of a new web page for the first time
    * Test input: url=<cia.gov>, time_elapsed = 0s
    * Should output: a JSON-API spec''d response that contains no records in the data key
2. Web page scraping/parsing is in progress
    * Desc: a user requests a web status record an nth time after the first time (for a specific url), where n corresponds to any time during which parsing has not yet been completed
    * Test input: url=<cia.gov>, time_elapsed < <time-required-to-parse-web-page>
    * Should output: a JSON-API spec''d response that contains a WebStatus record with the is-parsed field set to FALSE
3. Web page scraping/parsing is complete
    * Desc: a user requests a web status record an mth time after the first time (for a specific url), where m corresponds to any time that occurs after parsing has been completed
    * Test input: url=<cia.gov>, time-elapsed > <time-required-parse-web-page>
    * Should output: a JSON-API spec''d response that contains a WebStatus record with the is-parsed field set to TRUE
