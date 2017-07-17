require 'json'
require 'nokogiri'
require 'open-uri'

def parse_tables(page_url)
  
  if(page_url == nil || page_url == '') then
    return []
  end
  
  page_noko = Nokogiri::HTML(open(page_url))
  page_tables = page_noko.css('table')
  table_hashes = []
  table_counter = 1
  
  # For each table on the page...
  page_tables.each do |table|
    table_headers = []
    table_data = []
    
    # A header row is defined as a row which: is not anywhere inside a
    # tbody element; contains two or more th children; and is not empty
    table_rows = table.css('tr')
    num_header_rows = table_rows.length - table.css('tbody tr, tr th:only-of-type, tr:empty').length
    num_body_rows   = table_rows.length - num_header_rows
    
    STDOUT.puts "Begin processing table \##{table_counter.to_s.rjust(2, '0')}"
    STDOUT.puts "Table \##{table_counter.to_s.rjust(2, '0')}: total number of rows: #{table_rows.length}"
    STDOUT.puts "Table \##{table_counter.to_s.rjust(2, '0')}: number of header rows: #{num_header_rows}"
    STDOUT.puts "Table \##{table_counter.to_s.rjust(2, '0')}: number of body rows: #{num_body_rows}"
    STDOUT.puts
    
    # If valid headers exist, then for each one...
    for i in 0...(table_rows.length)
      # Insert a new row-subarray to the appropriate list of rows
      if(i < num_header_rows) then table_headers.push([])
      else table_data.push([])
      end
      
      # Add all the text to the row-subarray
      table.css('tr').css('th, td').map do |datum|
        if(i < num_header_rows) then table_headers[i].push(datum.text.strip)
        else table_data[i - num_header_rows].push(datum.text.strip)
        end
      end
    end
    
    table_hashes.push({
      'headers' => table_headers,
      'data'    => table_data,
    })
    
    table_counter += 1
  end
  
  return table_hashes
  
end

if __FILE__ == $0 then
  
  puts 'Begin example scraping of CIA World Factbook: GDP per Capita'
  puts 'https://www.cia.gov/library/publications/the-world-factbook/rankorder/2004rank.html'
  puts
  
  tables = parse_tables('https://www.cia.gov/library/publications/the-world-factbook/rankorder/2004rank.html')
  tables.each do |t|
    json = t.to_json
    if(json.length > 1024) then puts json[0...1024] + '...'
    else puts json
    end
    puts
  end
  
  puts 'Begin example scraping of CDC data: most recent asthma data'
  puts 'https://www.cdc.gov/asthma/most_recent_data.htm'
  puts
  
  tables = parse_tables('https://www.cdc.gov/asthma/most_recent_data.htm')
  tables.each do |t|
    json = t.to_json
    if(json.length > 1024) then puts json[0...1024] + '...'
    else puts json
    end
    puts
  end
  
  puts 'Begin example scraping of CDC data: National Health Interview Survey'
  puts 'https://www.cdc.gov/asthma/nhis/2015/table1-1.htm'
  puts
  
  tables = parse_tables('https://www.cdc.gov/asthma/nhis/2015/table1-1.htm')
  tables.each do |t|
    json = t.to_json
    if(json.length > 1024) then puts json[0...1024] + '...'
    else puts json
    end
    puts
  end
  
  # Some work needed: header/body row detection causes a crash
  # 
  # puts 'Begin example scraping of FBI data: Homicides by Weapon Type'
  # puts 'https://ucr.fbi.gov/crime-in-the-u.s/2013/crime-in-the-u.s.-2013/'\
  #      'offenses-known-to-law-enforcement/expanded-homicide/'\
  #      'expanded_homicide_data_table_8_murder_victims_by_weapon_2009-2013.xls'
  # puts
  # 
  # tables = parse_tables('https://ucr.fbi.gov/crime-in-the-u.s/2013/crime-in-the-u.s.-2013/'\
  #     'offenses-known-to-law-enforcement/expanded-homicide/'\
  #     'expanded_homicide_data_table_8_murder_victims_by_weapon_2009-2013.xls')
  # tables.each do |t|
  #   json = t.to_json
  #   if(json.length > 1024) then puts json[0...1024] + '...'
  #   else puts json
  #   end
  #   puts
  # end
  
end
