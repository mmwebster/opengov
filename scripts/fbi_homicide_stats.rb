require 'HTTParty'
require 'JSON'
require 'Nokogiri'

# FBI homicide statistics, 2009-2013, by weapon type
PAGE_URL = 'https://ucr.fbi.gov/crime-in-the-u.s/2013/crime-in-the-u.s.-2013/'\
           'offenses-known-to-law-enforcement/expanded-homicide/'\
           'expanded_homicide_data_table_8_murder_victims_by_weapon_2009-2013.xls'

page_str = HTTParty.get(PAGE_URL)
page_noko = Nokogiri::HTML(page_str)

page_title = page_noko.css('title')[0].text
table_headers = []
table_data = []

# Store the table headers
page_noko.css('table.data').css('thead').css('tr').css('th').map do |header|
  table_headers.push(header.text.strip())
end

# Store the main table data in a 2D array, [row][column]
data_row_index = 0
page_noko.css('table.data').css('tbody').css('tr').map do |body_row|
  table_data.push([])
  
  table_data[data_row_index].push(body_row.css('th')[0].text.strip())
  body_row.css('td').map do |datum|
    table_data[data_row_index].push(datum.text.strip())
  end
  
  data_row_index += 1
end

# Store all the data as a hash table
data_hash = {
  "title" => page_title,
  "data"  => [table_headers],
}

# Add the main body of the data iteratively, for an arbitrary length
table_data.each do |datum|
  data_hash["data"].push(datum)
end

# Convert the hash table into a JSON string. The JSON will be of the following format:
# {
#   title: page_title
#   data: [
#     table_headers,
#     table_data[0],
#     table_data[1],
#     ...
#   ]
# }

data_json = data_hash.to_json
puts data_json
