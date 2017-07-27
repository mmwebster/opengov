# Working Prototype Known Problems Report
## 27 July 2017

## Functions/Features Not Working

* Unfinished string parsing in worker --> DB
  * String refinement is not optimized to understand the type of data being stored. 
    * Float, int, string ...
* API SQL query filtering w/ multiple ‘WHERE’ params
  * Unable to distinguish certain search parameters of type: “A.B.C” where you can specify a certain node and get all appropriate results 
* Scraper/Parser Worker for improved modularity and readability
  * Unable to manage rowspan values 
    * However, test code is there to throw a warning showing table misread
  * Unable to manage left column headers for a table
    * Multiple column headers will mess up the table alignment and cause incorrect data references
    * Single column headers will forget to check the last column
* Machine learning for parsing algorithm
  * There is no existing ML currently despite it being one of our release plan goals
* Heroku does not work live currently, only local
  * Easy fix, but we already have pushed all our files for the deadline
* Unable to use multi-word key names unless delimited by dashes
  * Was a quick fix due to limited time
* Keys in user queries must be all lowercase 


