# OpenGov — WebData API Module Unit Testing
## 27 July 2017

## Module Description
The WebData module consists of all submodules servicing functionality of the /api/v1/web-data?filter[query]=<query> API endpoint. This includes user query parsing/structure and Rails ActiveRecord filtering based on the parsed user query. Due to the nature of data representation in the database (designed to support arbitrary data types and relations), user queries cannot simply be sanitized and then executed as direct SQL queries, but must instead be translated to equivalent ActiveRecord filtering operations on the entire web page''s data set. By doing so, users can query their parsed data through an SQL interface with names and values that don''t directly correspond to the database schema and are much more user-friendly.

## Equivalence Classes & Corresponding Unit Tests
### Note: <cia.gov> = 'https://www.cia.gov/library/publications/the-world-factbook/rankorder/2127rank.html'
### Note: All equivalence classes are under the condition of the web page already having been successfully parsed
1. Key names are single words
    * Desc: Key names in user inputted query contain only single-word key names
    * Test input: query="SELECT country FROM <cia.gov> WHERE rank == 10"
    * Should output: a single web datum corresponding to the 10th country listed in the table
    * Exact value: Afghanistan
2. Key names contain multiple words
    * Desc: Key names in user inputted query contain multi-word key names
    * Test input: query="SELECT date-of-information FROM <cia.gov> WHERE (children-born/woman) == 6.04"
    * Should output: a single web datum corresponding to Date of Information for the country with children born per woman equal to 6.04
    * Exact value: 2016 est.
3. Values are integers
    * Desc: Values in user inputted query contain only integers
    * Test input: query="SELECT country FROM <cia.gov> WHERE rank == 2"
    * Should output: a single web datum corresponding to the second country listed in the table
    * Exact value: mali
4. Values are floats
    * Desc: Values in user inputted query contain only floats
    * Test input: query="SELECT country FROM <cia.gov> WHERE (children-born/woman) == 5.95"
    * Should output: a single web datum corresponding to the country with (children-born/woman) equal to 5.95
    * Exact value: mali
5. Values are strings
    * Desc: Values in user inputted query contain only strings
    * Test input: query="SELECT (children-born/woman) FROM <cia.gov> WHERE country == 'burundi'"
    * Should output: a single web datum corresponding to the ratio of children born per woman for the country of Burundi
    * Exact value: 6.04
6. Operators are ==
    * Desc: Operators in user inputted query contain only the double equals operator
    * Test input: query="SELECT country from <cia.gov> WHERE rank == 5"
    * Should output: a single web datum corresponding to the country that has rank 5
    * Exact value: uganda
6. Operators are !=
    * Desc: Operators in user inputted query contain only the not-equals operator
    * Test input: query="SELECT country from <cia.gov> WHERE rank != 5"
    * Should output: 223 web datum records corresponding to the countries that are not in the 5th place in the table rows
    * Exact value: N/A
6. Operators are >
    * Desc: Operators in user inputted query contain only greater-than oeprator
    * Test input: query="SELECT country from <cia.gov> WHERE rank > 223"
    * Should output: a single web datum corresponding to the 224th country in the table
    * Exact value: singapore
6. Operators are <
    * Desc: Operators in user inputted query contain only the less-than operator
    * Test input: query="SELECT country from <cia.gov> WHERE rank < 2"
    * Should output: a single web datum corresponding to the 1st country in the table
    * Exact value: niger
6. Operators are >=
    * Desc: Operators in user inputted query contain only greater-than or equal-to operator
    * Test input: query="SELECT country from <cia.gov> WHERE rank >= 223"
    * Should output: two web datum records corresponding to the last two countries in the table
    * Exact value: macau and singapore
6. Operators are <=
    * Desc: Operators in user inputted query contain only the less-than or equal-to operator
    * Test input: query="SELECT country from <cia.gov> WHERE rank <= 2"
    * Should output: two web datum records corresponding to the first two countries in the table
    * Exact value: niger and burundi
