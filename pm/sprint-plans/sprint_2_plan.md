# OpenGov Sprint 2 Plan

## Date: 11- 18 July 2017

## Sprint Attributes and Nomenclature

* Story Point to Hours Ratio: 2 to 1
* Story Point Scale: 1, 2, 3, 5, 8, 13, 20

## User Stories
* As a data analyst, I want the data I query (from the following websites) to undergo basic parsing so that I don’t have to manually parse them:
    * Story points: 8
    * Assigned to: David Krieger, Daniel Hildebrandt
    * Implementing as: Basic scraper/parser
    * https://www.cia.gov/library/publications/the-world-factbook/
    * https://www.cdc.gov/datastatistics/index.html
    * https://ucr.fbi.gov/
* As a data analyst, I want to be confident that the data I query is accurate
    * Story points: 20
    * Assigned to: Daniel Hildebrandt, Anthony Awaida
    * Implementing as: A separate parsing algorithm to be compared to and combined with the first one, reinforcement ML to modify parameters to the base algorithm on a website-to-website basis
* As a data analyst, I want to be able to send requests to the OpenGov API in order to check the status of parsing and website and to query data from the website once it has been parsed
    * Story points: 
    * Assigned to: Milo Webster
    * Implementing: Basic API and associated infrastructure (Rails, Postgres, Worker Dynos) to serve this application in production
