# OpenGov System and Unit Test Report
## 27 July 2017

### Per Sprint User Stories 

* User story 1 from sprint 2: As a data analyst, I want the data I query to undergo basic parsing so that I don’t have to manually parse them.
* User story 3 from sprint 2: As a data analyst, I want to be able to send requests to the OpenGov API in order to check the status of parsing and website and to query data from the website once it has been parsed.
* User story 1 from sprint 3: As a data analyst, I want the data I query to successfully parse via my requests to the API so that I can fully utilize OpenGov.
* User story 3 from sprint 3: As a data analyst, I want to be able to make queries to OpenGov with SQL-style commands so that I have a familiar and powerful query interface.

*****

### System Test Scenario - We have a single scenario with multiple potential outcomes. Flow chart style:


1. Make a GET request to opengov-api.herokuapp.com/api/v1/web-statuses?filter[url]=<web-page-url>
  a. Parse raw response as JSON-API spec’d JSON
2. Check to see if the response contains a record
  a. If the “is-parsed” attribute on the record is TRUE
    i. Skip to step #3
  b. If the “is-parsed” attribute on the record is FALSE
    i. Use scraper_parser worker to read in data table(s) and format for DB
    i. Store all keys→ values as well as related key fields
3. Search Database and return values based on the user’s request
  a. If fields don’t match 
    i. Return empty
  b. Else
    i. Return values found

System Test Scenarios: System tests located at https://github.com/mmwebster/opengov/tree/master/testing
