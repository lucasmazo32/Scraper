#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'

s1 = Scraper.new

arr = ['', '-------------', '']

#puts s1.table_creation('Salary Estimate', 1, s1.page_url)
#puts arr
#puts s1.table_creation('Job Type', 2, s1.page_url)
#puts arr
#puts s1.table_creation('Location', nil, s1.page_url)


for i in 0...3
    puts s1.city(s1.loc_link(i))
    puts ''
    puts s1.table_creation('Salary Estimate', 1, s1.loc_link(i))
    puts arr
    puts s1.table_creation('Job Type', 2, s1.loc_link(i))
    puts ['','******************','']
end
