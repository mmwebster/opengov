# OpenGov — WebData API Module Unit Testing
## 27 July 2017

## Module Description
The WebData module consists of all submodules servicing functionality of the /api/v1/web-data?filter[query]=<query> API endpoint. This includes user query parsing/structure and Rails ActiveRecord filtering based on the parsed user query. Due to the nature of data representation in the database (designed to support arbitrary data types and relations), user queries cannot simply be sanitized and then executed as direct SQL queries, but must instead be translated to equivalent ActiveRecord filtering operations on the entire web page''s data set. By doing so, users can query their parsed data through an SQL interface with names and values that don''t directly correspond to the database schema and are much more user-friendly.

## Equivalence Classes & Corresponding Unit Tests
1. Key names are single words
    2. 
2. Key names contain multiple words
