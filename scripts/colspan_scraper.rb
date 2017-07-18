require 'json'
require 'nokogiri'
require 'open-uri'

def parse_tables(page_url)

  if(page_url == nil || page_url == '') then
    puts "Error reading given URL (nil)"
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

    puts "==========================================================================================="
    puts
    STDOUT.puts "Begin processing table \##{table_counter.to_s.rjust(2, '0')}"
    STDOUT.puts "Table \##{table_counter.to_s.rjust(2, '0')}: total number of rows: #{table_rows.length}"
    STDOUT.puts "Table \##{table_counter.to_s.rjust(2, '0')}: number of header rows: #{num_header_rows}"
    STDOUT.puts "Table \##{table_counter.to_s.rjust(2, '0')}: number of body rows: #{num_body_rows}"
    puts


    $final_span = 0
    $span_check = []
    table_head_array = [[],[]]

    for i in 0..(num_header_rows - 1)

      $span_check [i] = 0

      #puts "The row text is: #{table_rows[i].text}"

      table_rows[i].css("th").each_with_index do |check|

        colspan = check["colspan"]

        if (colspan.to_i > 1)

          for k in ($span_check[i]..colspan.to_i + $span_check[i] - 1)


            #Append current text from current column into all subsequent lower columns
            for j in i ..(num_header_rows - 1)
              puts "Appending into current and lower row arrays the values #{j} #{k} #{check.text}"
              #table_head_array[[j],[k]] = table_head_array[[i],[k]] << ".#{check.text}"
            end
            puts
          end

          #didnt like += for some reason...
          #This counts the number of col spans in this row. Incase they wind up different, choose largest
          $span_check[i] = $span_check[i] + colspan.to_i
          #puts "The value of spancheck is #{$span_check[i]}"

          #Update col span based on current iteration and largest one found on each row
          if $final_span < $span_check[i]
            $final_span = $span_check[i]
            #puts "updated final_span to be #{$final_span}"
          end

        else
          #No phrase col span found or is exactly 1, let both increment by 1

          #first insert current phrase at location and append to all subsequent rows beneath
          for j in i ..(num_header_rows - 1)
            #table_head_array[j][$span_check[k]] = table_head_array[[i],[k]] << ".#{check.text}"
            puts "Appending into current and lower row arrays the values #{j} #{$span_check[i]} #{check.text}"
            puts
          end

          $span_check[i] = $span_check[i] + 1

          #puts "Inserting into array value: #{i} #{k} the words #{check.text}"

        end



      end
      puts
      #puts "final_span on iteration #{i} is #{$final_span}"
      puts

    end

    puts "Largest final_span after everything is #{$final_span}"
    puts "\n=========================================================================================="
    puts


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

  puts '\nBegin example scraping of CIA World Factbook: GDP per Capita'
  puts 'https://www.cia.gov/library/publications/the-world-factbook/rankorder/2004rank.html'
  puts

  tables = parse_tables('https://www.epa.gov/recalls/fuel-economy-label-updates#ford')
  tables.each do |t|
    json = t.to_json
    if(json.length > 1024) then puts json[0...1024] + '...'
    else puts json
    end
    puts
  end

=begin
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
=end

end
