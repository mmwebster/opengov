# OpenGov module_parser Unit testing
## 27 July 2017

## Various table format testing w/ pictures

Single Data Table, Easy Format
* CIA.gov factbook was one of the original websites we chose that we would develop an algorithm on. It is very straightforward in how the html markup works and made it very easy for us to read in the data
  * Raw url: https://www.cia.gov/library/publications/the-world-factbook/rankorder/2127rank.html'
  * One table
  * Single line of table headers
  * Col/Row alignment are linear 1:1
  * Every Table Data entry has a spot in the table
    * https://drive.google.com/open?id=0B1_MtIXVAOVGRVp1YkhxYTZWSGc
  
*****
  
Multiple Tables, Medium Format
* The next URL we tested was from the cdc. Here we learned about reading in multiple tables and sorting the data appropriately.
  * Raw url: https://www.cdc.gov/asthma/most_recent_data.htm
  * Multiple tables, 5
  * Single line of table headers
  * Col & Row alignment are linear 1:1, no spans
  * Some data fields are NULL
  * Output of unit test
    * https://drive.google.com/open?id=0B1_MtIXVAOVGYjIyeWZQWUFrTkE
  * CSS markup
    * https://drive.google.com/open?id=0B1_MtIXVAOVGMGkzQkZOVDd1VWM

*****

Multiple Tables, Hard Format (Col/Row Span)
* After successfully reading in multiple tables given a single URL, we sought to improve general ability to read in more complex tables. We first started with learning how to read in and append multiple table header columns together. This involved also learning about col_span values.
  * Raw url: https://www.epa.gov/recalls/fuel-economy-label-updates#ford
  * Col & Row alignment are not traditional, must acount for spans
  * We can see successful appending by the A.B.C format
    * A being the parent of the child B
    * Goal was to allow user to search through multiple header parameters
  * Here is an example of success regarding reading in multiple table header rows as well as accounting for col_span header associations. 
    * https://drive.google.com/open?id=0B1_MtIXVAOVGd3FWYTl5WktmVWc
  * Here is an example of failure due to having row span values which we failed to create an algorithm which would account for it. Note: We successfully throw an error stating that the table was potentially miss read to tell the user that it is not working properly.
    * https://drive.google.com/open?id=0B1_MtIXVAOVGQW84dEhIQ0FpUXM
  * Here is the css markup showing both row & colspan and how they relate to formatting column headers: 
     * https://drive.google.com/open?id=0B1_MtIXVAOVGcWo4Y0N3WnlKQnc

*****

Single Table, Hard Format (left column)
* Some tables have column headers at the top ('th') as well as on the first column on the left. This can make it very difficult to properly format a table as well as have the correct header appends happen for the appropriate rows it specifies to
  * Raw url: https://ucr.fbi.gov/crime-in-the-u.s/2013/crime-in-the-u.s.-2013/offenses-known-to-law-enforcement/expanded-homicide/expanded_homicide_data_table_8_murder_victims_by_weapon_2009-2013.xls 
  * We created a case that if there 2+ 'th' in a row then it must be at the top of the table. If there is only 1 'th' tag in the row, then it must be a special header tag that gets appended to only those row values.
    * Here is a the picture showing the output regarding left hand column headers in addition to top row 'th' headers
      * https://drive.google.com/open?id=0B1_MtIXVAOVGZVFhejN0VTBHMjA
    * This is the markup for the webpage:
      * https://drive.google.com/open?id=0B1_MtIXVAOVGdFBZVEl1SVRlQW8
    
