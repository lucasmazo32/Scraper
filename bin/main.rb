#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require_relative '../lib/builder.rb'

s1 = Scraper.new
b1 = Builder.new

File.delete("test.html")
file = File.new("test.html",'w')
file.write(b1.lis(s1.table_creation('Salary Estimate', 1, s1.page_url)), 'sal')
file.write(b1.lis(s1.table_creation('Job Type', 2, s1.page_url)), 'job')
file.write(b1.lis(s1.table_creation('Salary Estimate', 1, s1.page_url)), 'sal')
file.close

puts `xdg-open test.html`

