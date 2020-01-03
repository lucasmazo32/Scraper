#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require_relative '../lib/builder.rb'
require_relative '../lib/fast_scraper.rb'

# Code for user interaction
puts `clear`
puts 'Welcome to the job scraper from indeed. If you want to add a custom link paste it on the chat, otherwise just press enter.'
puts 'Remember that the link SHOULD start with https://www.indeed.com'

link = gets.chomp

if link.nil? || link.empty? || (/\S/).match(link).nil?
    f1 = Fast.new
    s1 = Scraper.new
else
    ver = link.match('https://www.indeed.com/').nil?
    while ver
        puts `clear`
        puts 'Oops, it seems you enter a WRONG link.'
        puts 'Please paste a correct one or just press enter to continue with our default scrap.'
        link = gets.chomp
        ver = !(link.match('https://www.indeed.com/').nil? || (link.nil? || link.empty? || (/\S/).match(link).nil?))
    end
    if link.nil? || link.empty? || (/\S/).match(link).nil?
        f1 = Fast.new
        s1 = Scraper.new
    else
        f1 = Fast.new(link)
        s1 = Scraper.new(link)
    end
end

# Code to make the GUI

b_fast = Builder.new

fast_url = f1.page_url
fast_title = f1.title
job_fast = f1.url_name

file = File.new('./html/fast.html', 'w')
b_fast.page_title(1)
b_fast.hyper(fast_url, 'search-title')
b_fast.title(fast_title, 'search-title')
b_fast.fast(job_fast[0], job_fast[1])

file.write(b_fast.trans_html)
file.close

puts `xdg-open ./html/fast.html`

b1 = Builder.new

search_title = s1.search_title # Title of the page
main_url = s1.page_url # Page url
city_link = s1.loc_link # Cities URL's
city = s1.city # Cities Name
salary_main = s1.table_creation('Salary Estimate', s1.page_url, 1) # Table of the main page
job_main = s1.table_creation('Job Type', s1.page_url, 2) # Table of the main page
loc_main = s1.table_creation('Location', s1.page_url) # Table of the main page
salary_city2 = s1.table_creation('Salary Estimate', city_link[1], 1) # Table for cities
salary_city1 = s1.table_creation('Salary Estimate', city_link[0], 1) # Table for cities
salary_city3 = s1.table_creation('Salary Estimate', city_link[2], 1) # Table for cities
job_city1 = s1.table_creation('Job Type', city_link[0], 2) # Table for cities
job_city2 = s1.table_creation('Job Type', city_link[1], 2) # Table for cities
job_city3 = s1.table_creation('Job Type', city_link[2], 2) # Table for cities
jobs_link_city1 = s1.first(0)
jobs_link_city2 = s1.first(1)
jobs_link_city3 = s1.first(2)
yoe1 = s1.yoe(0)
yoe2 = s1.yoe(1)
yoe3 = s1.yoe(2)

file = File.new('./html/complete.html', 'w')

b1.page_title
b1.hyper(main_url, 'search-title')
b1.hyper(city_link[0], 'city1-title')
b1.hyper(city_link[1], 'city2-title')
b1.hyper(city_link[2], 'city3-title')
b1.title(search_title, 'search-title')
b1.title(city[0], 'city1-title')
b1.title(city[1], 'city2-title')
b1.title(city[2], 'city3-title')
b1.lis(salary_main, 4, 'main', 'sal')
b1.lis(job_main, 4, 'main', 'job')
b1.lis(loc_main, 4, 'main', 'loc')
b1.lis(salary_city1, 6, 'city1', 'sal')
b1.lis(salary_city2, 6, 'city2', 'sal')
b1.lis(salary_city3, 6, 'city3', 'sal')
b1.lis(job_city1, 6, 'city1', 'job')
b1.lis(job_city2, 6, 'city2', 'job')
b1.lis(job_city3, 6, 'city3', 'job')
b1.jobs(yoe1[0], yoe1[1], jobs_link_city1, 'city1')
b1.jobs(yoe2[0], yoe2[1], jobs_link_city2, 'city2')
b1.jobs(yoe3[0], yoe3[1], jobs_link_city3, 'city3')

file.write(b1.trans_html)
file.close

puts `xdg-open ./html/complete.html`
