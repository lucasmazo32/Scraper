#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'

s1 = Scraper.new

puts s1.table_creation('Salary Estimate', 1)
puts s1.table_creation('Job Type', 2)
puts s1.table_creation('Location')