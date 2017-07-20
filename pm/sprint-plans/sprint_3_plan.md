# OpenGov Sprint 3 Plan

## Date: 19 - 24 July 2017

## Sprint Attributes and Nomenclature

* Story Point to Hours Ratio: 2 to 1
* Story Point Scale: 1, 2, 3, 5, 8, 13, 20, 40

## User Stories
* As a data analyst, I want the data I query to successfully parse via my requests to the API so that I can fully utilize OpenGov
    * Story points: 13
    * Assigned to: David Krieger, Daniel Hildebrandt
    * Tasks Required (David Krieger):
        * Setup rails and req''s to run API
        * Integrate scraper into API
        * Debug errors thrown in rails
        * Analyze data output and refine scraper as needed
        * Finish integrating David & Daniels sections of scraper code
        * Write specific web drivers if needed
    * Tasks Required (Daniel Hildebrandt)
        * Format output of parser into web_datum-compatible rows (run “WebDatum” in the rails console (“rails c”) to see the model properties)
        * Insert all records into postgres through the ActiveRecord interface
        * After finishing all of my tasks, help David (particularly on integration of the two parsing algorithms)

* As a data analyst, I want to be confident that the data I query is accurate so that my analyses are accurate.
    * Story points: 40
    * Assigned to: Milo Webster, Anthony Awaida
    * Tasks Required (Anthony Awaida):
        * Identify an ML algorithm
        * Write pseudocode for the ML implementation
    * Tasks Required (Milo Webster):
        * Design the interaction between the ML processes and the base parsing algorithm
        * Implement architecture of ML interaction with base algorithm
        * Implement ML algorithm inside the new framework

* As a data analyst, I want to be able to make queries to OpenGov with SQL-style commands so that I have a familiar and powerful query interface
    * Story points: 8
    * Assigned to: Milo Webster
    * Tasks Required:
        * Add a “query” filter for the api/v1/web-data endpoint
        * Design the parsing scheme for sql queries
        * Design the escaping scheme for sql queries
        * Implement sql parsing and associated code to fetch the necessary web-datum record(s)

## Sprint 3 Scrum Board
View our active scrum board at: https://tree.taiga.io/project/mmwebster-opengov/taskboard/sprint-3-2291
