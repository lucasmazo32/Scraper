#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require_relative '../lib/builder.rb'

b1 = Builder.new
s1 = Scraper.new

search_title = s1.search_title # Title of the page
main_url = s1.page_url # Page url
salary_main = s1.table_creation('Salary Estimate', 1, s1.page_url) # Table of the main page
job_main = s1.table_creation('Job Type', 2, s1.page_url) # Table of the main page
loc_main = s1.table_creation('Location', nil, s1.page_url) # Table of the main page

file = File.new('./html/complete.html', 'w')

b1.hyper(main_url, 'search-title')
b1.title(search_title, 'search-title')
b1.lis(salary_main, 4, 'main', 'sal')
b1.lis(job_main, 4, 'main', 'job')
b1.lis(loc_main, 4, 'main', 'loc')

file.write(b1.to_html)
file.close

puts `xdg-open ./html/complete.html`

city_link = s1.loc_link # Cities URL's
city = s1.city # Cities Name

file = File.new('./html/complete.html', 'w')

b1.hyper(city_link[0], 'city1-title')
b1.hyper(city_link[1], 'city2-title')
b1.hyper(city_link[2], 'city3-title')
b1.title(city[0], 'city1-title')
b1.title(city[1], 'city2-title')
b1.title(city[2], 'city3-title')

file.write(b1.to_html)
file.close
####################
salary_city1 = s1.table_creation('Salary Estimate', 1, city_link[0]) # Table for cities
job_city1 = s1.table_creation('Job Type', 2, city_link[0]) # Table for cities

file = File.new('./html/complete.html', 'w')

b1.lis(salary_city1, 3, 'city1', 'sal')
b1.lis(job_city1, 3, 'city1', 'job')

file.write(b1.to_html)
file.close
##################
salary_city2 = s1.table_creation('Salary Estimate', 1, city_link[1]) # Table for cities
job_city2 = s1.table_creation('Job Type', 2, city_link[1]) # Table for cities

file = File.new('./html/complete.html', 'w')

b1.lis(salary_city2, 3, 'city2', 'sal')
b1.lis(job_city2, 3, 'city2', 'job')

file.write(b1.to_html)
file.close
#################################
salary_city3 = s1.table_creation('Salary Estimate', 1, city_link[2]) # Table for cities
job_city3 = s1.table_creation('Job Type', 2, city_link[2]) # Table for cities

file = File.new('./html/complete.html', 'w')

b1.lis(salary_city3, 3, 'city3', 'sal')
b1.lis(job_city3, 3, 'city3', 'job')

file.write(b1.to_html)
file.close
###############################
jobs_link_city1 = s1.first(0)
yoe1 = s1.yoe(0)

file = File.new('./html/complete.html', 'w')

b1.jobs(yoe1[0], yoe1[1], jobs_link_city1, 'city1', 5)

file.write(b1.to_html)
file.close
####################################
jobs_link_city2 = s1.first(1)
yoe2 = s1.yoe(1)

file = File.new('./html/complete.html', 'w')

b1.jobs(yoe2[0], yoe2[1], jobs_link_city2, 'city2', 5)

file.write(b1.to_html)
file.close
########################
jobs_link_city3 = s1.first(2)
yoe3 = s1.yoe(2)

file = File.new('./html/complete.html', 'w')

b1.jobs(yoe3[0], yoe3[1], jobs_link_city3, 'city3', 5)

file.write(b1.to_html)
file.close

puts 'fully loaded'
