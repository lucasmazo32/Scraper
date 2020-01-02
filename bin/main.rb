#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require_relative '../lib/builder.rb'

b1 = Builder.new
s1 = Scraper.new

File.delete("test.html")
file = File.new("test.html",'w')
b1.lis(s1.table_creation('Salary Estimate', 1, s1.page_url),'sal')
b1.lis(s1.table_creation('Job Type', 2, s1.page_url),'job')
b1.lis(s1.table_creation('City', nil, s1.page_url),'loc')
file.write(b1.to_html)
file.close

puts `xdg-open test.html`
