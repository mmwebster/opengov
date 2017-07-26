# OpenGov Project Outline

## July 4th 2017

## Objective
OpenGov is a public API for government-supplied environmental and political data. OpenGov uses heuristics and ML to structure data so that it can more easily be used for analysis by software developed for environmental and political activism.

## Summary of Architecture
* Scraper: Ruby
    * Desc: Pull different data formats
    * Design constraints:
        * Must be able to scrape and parse multiple web pages within a website concurrently (or in parallel if possible)
        * Must be able to notify the API when the data has been parsed and inserted into the database
* API: Ruby on Rails
    * Design constraints:
        * Must use a common convention across all endpoints
        * Must not cost money...Heroku
* Database: Postgres (Maybe Redis too, depending on how we represent data)
    * Design constraints:
        * Must be able to store at least 10k rows for now
        * Must contain data indexed key name strings

## Possible design approaches
* Data oriented approach: User requests data, we see if we have it, we scrape and parse
websites that contain this data if we don’t have it
* Webpage oriented approach: User requests structured data from website A, we see if we have parsed the data in website A, we scrape and parse website A if not. < Doing this one

## Data node format
* Key
* Date/Timestamp
* Value

## Request format
* Websites
* Data keys
* Date/Timestamp

## Use Case
* User hits one of our API endpoints with a request for some keys from some websites
* We check to see if we already scraped this data from these websites
    * Scrape it if not
* Return keys from the database
