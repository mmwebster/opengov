#Required gems
require 'rubygems'
require 'nokogiri'
require 'open-uri'

###############################


def formatDT (page)

  tables = page.css("table")

  #Go through each table and organize it
  for t in 0..(tables.length - 1)

    #Find table headers
    puts "Processing table number #{t}"
    table_head = tables[t].css("th")

    #Uses first row to develop header
    if table_head.empty?
      table_head = tables[t].css("tbody tr[0] td")

      #Nothing even in the table...
      if table_head.empty?
        puts "No table header within this table, not valid to parse"
        puts
      end

    end

    #Found valid table w/ headers to scrape
    if !table_head.empty?

      #Get all rows and allocate array
      rows = tables[t].css("tr")
      formatedTable = Array.new((rows.length)) {Array.new(table_head.length)}

      #Stores table headers in row 0 of the array, formatedTable
      for h in 0..(table_head.length - 1)
        formatedTable[0][h] = 0, table_head[h].text
        puts "The Header row,data values are: #{formatedTable[0][h]}"
      end

      #All subsequent table data row & column storage.
      #Searches for table data per row, and if found, store in proper header index (column)
      for r in 0..(rows.length - 1)
        rows[r].css("td").each_with_index do |td, j|
          formatedTable[r][j] = r, td.text
          puts "row,data values are: #{formatedTable[r][j]}"
          puts "Data type: #{formatedTable[0][j]}"
        end
        puts

      end
      puts

    end

  end

end

print "\nStarting scraper \n\n"

#Works for cia.gov links, the easiest to scrape
#PAGE_URL = "https://www.cia.gov/library/publications/the-world-factbook/rankorder/2004rank.html"

#Works for Multiple tables, and empty data columns.
PAGE_URL = "https://www.cdc.gov/asthma/most_recent_data.htm"

################################################################################
#DOES NOT WORK for tables with multiple rows of table headers currently
#PAGE_URL = "https://www.cdc.gov/asthma/nhis/2015/table1-1.htm"
###############################################################################

page = Nokogiri::HTML(open(PAGE_URL))

formatDT(page)

puts
