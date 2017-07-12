require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = "https://www.cia.gov/library/publications/the-world-factbook/rankorder/2004rank.html"

print "\nStarting my scraper\n\n===================================================================================\n\n"

page = Nokogiri::HTML(open(PAGE_URL))
puts "The webpage title is: #{page.css("title")[0].text}"   # => My webpage

country_links = page.css("td[class=region] a")
puts "The first_country link found within the table is for: #{country_links[0].text}"

headers = page.css("table tr[class=rankHeading] th")
n = headers.length

table_heads = headers.map do |e| e.text.dup end
puts "The table heads are #{table_heads}"


whole_table = page.css("table tr td")
puts "The table length is #{whole_table.length}"
puts "The country of the last table index is #{whole_table[whole_table.length - 2].text}"

#This sorts the table into a two dimmensional array[row][column]
i = 0
table_row = Array.new(whole_table.length/n) { Array.new(n)}
for j in 0..(whole_table.length - 1)

  if ((j%n) == 0) and (j != 0)
    puts
    i += 1
  end

  table_row[i][j%n] = whole_table[j].text
  puts "Currently on row #{[i]} and the column data is: #{table_row[i][j%n]}"

end

puts
