# OpenGov Sprint #3 Report
## 26 July 2017

## Actions to stop doing:
* Some tunnel vision when working on specific files
* Leaving legacy code, remove it

## Actions to start doing:
* Integrate isolated environments earlier
* Code standard and clean code
  * David - Use more methods!

## Actions to keep doing:
* Screenshare and peer review/help if very stuck
  * Its best for the team to help in that instance
* Refine Scraping Algorithm

## Work Completed
* Scraper integration into API
* Parser modification to insert records into DB
* API sql query-based filter and search
* Parsing status and parsed data handshake through API endpoints

## Work Not Completed:
* Unfinished string parsing in worker --> DB
  * (All numerics are coverted to floats and strings with spaces are converted to dashes)
* API SQL query filtering w/ multiple WHERE params
* Refactoring Scraper/Parser Worker for improved modularity and readability
* Machine learning for parsing algorithm

## Work Completion rate: 
* Product is deliverable!
  * Capable of parsing table data in web pages and providing an SQL interface for querying data through the public API on Heroku
* Burnup chart available here: https://drive.google.com/a/ucsc.edu/file/d/0B2F5t4DqJGYWZ1RzOWotMTkxNVk/view?usp=sharing
