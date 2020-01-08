#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require_relative '../lib/builder.rb'
require_relative '../lib/fast_scraper.rb'
require 'os'

def verification(condition)
    while condition
        puts `clear`
        puts 'Oops, it seems you enter a WRONG link.'
        puts 'Please paste a correct one or just press enter to continue with our default scrap.'
        link = gets.chomp
        condition = !(link.match?('https://www.indeed.com/') || (link.nil? || link.empty? || (/\S/).match(link).nil?))
    end
    link
end

# Code for user interaction
puts `clear`
puts 'Welcome to the job scraper from indeed. If you want to add a custom link paste it on the chat, otherwise just press enter.'
puts 'Remember that the link SHOULD start with https://www.indeed.com'

link = gets.chomp

if link.nil? || link.empty? || (/\S/).match(link).nil?
    fast_scraper = Fast.new
    complete_scraper = Scraper.new
else
    ver = link.match('https://www.indeed.com/').nil?
    link = verification(ver)
    if link.nil? || link.empty? || (/\S/).match(link).nil?
        fast_scraper = Fast.new
        complete_scraper = Scraper.new
    else
        fast_scraper = Fast.new(link)
        complete_scraper = Scraper.new(link)
    end
end

# Code to make the GUI

builder_fast = Builder.new

fast_url = fast_scraper.page_url
fast_title = fast_scraper.title
job_fast = fast_scraper.url_name

file = File.new('./html/fast.html', 'w')
builder_fast.page_title(1)
builder_fast.hyperlink(fast_url, 'search-title')
builder_fast.title(fast_title, 'search-title')
builder_fast.fast_jobs(job_fast[0], job_fast[1])

file.write(builder_fast.trans_html)
file.close

puts `xdg-open ./html/fast.html`

builder_complete = Builder.new

search_title = complete_scraper.search_title # Title of the page
main_url = complete_scraper.page_url # Page url
city_link = complete_scraper.loc_link # Cities URL's
city = complete_scraper.city # Cities Name
salary_main = complete_scraper.table_creation('Salary Estimate', complete_scraper.page_url, 1) # Table of the main page
job_main = complete_scraper.table_creation('Job Type', complete_scraper.page_url, 2) # Table of the main page
loc_main = complete_scraper.table_creation('Location', complete_scraper.page_url) # Table of the main page
salary_city2 = complete_scraper.table_creation('Salary Estimate', city_link[1], 1) # Table for cities
salary_city1 = complete_scraper.table_creation('Salary Estimate', city_link[0], 1) # Table for cities
salary_city3 = complete_scraper.table_creation('Salary Estimate', city_link[2], 1) # Table for cities
job_city1 = complete_scraper.table_creation('Job Type', city_link[0], 2) # Table for cities
job_city2 = complete_scraper.table_creation('Job Type', city_link[1], 2) # Table for cities
job_city3 = complete_scraper.table_creation('Job Type', city_link[2], 2) # Table for cities
jobs_link_city1 = complete_scraper.first_links(0)
jobs_link_city2 = complete_scraper.first_links(1)
jobs_link_city3 = complete_scraper.first_links(2)
years_of_experience1 = complete_scraper.years_of_experience(0)
years_of_experience2 = complete_scraper.years_of_experience(1)
years_of_experience3 = complete_scraper.years_of_experience(2)

file = File.new('./html/complete.html', 'w')

builder_complete.page_title
builder_complete.hyperlink(main_url, 'search-title')
builder_complete.hyperlink(city_link[0], 'city1-title')
builder_complete.hyperlink(city_link[1], 'city2-title')
builder_complete.hyperlink(city_link[2], 'city3-title')
builder_complete.title(search_title, 'search-title')
builder_complete.title(city[0], 'city1-title')
builder_complete.title(city[1], 'city2-title')
builder_complete.title(city[2], 'city3-title')
builder_complete.job_data(salary_main, 4, 'main', 'sal')
builder_complete.job_data(job_main, 4, 'main', 'job')
builder_complete.job_data(loc_main, 4, 'main', 'loc')
builder_complete.job_data(salary_city1, 6, 'city1', 'sal')
builder_complete.job_data(salary_city2, 6, 'city2', 'sal')
builder_complete.job_data(salary_city3, 6, 'city3', 'sal')
builder_complete.job_data(job_city1, 6, 'city1', 'job')
builder_complete.job_data(job_city2, 6, 'city2', 'job')
builder_complete.job_data(job_city3, 6, 'city3', 'job')
builder_complete.jobs(years_of_experience1[0], years_of_experience1[1], jobs_link_city1, 'city1')
builder_complete.jobs(years_of_experience2[0], years_of_experience2[1], jobs_link_city2, 'city2')
builder_complete.jobs(years_of_experience3[0], years_of_experience3[1], jobs_link_city3, 'city3')

file.write(builder_complete.trans_html)
file.close

puts `xdg-open ./html/complete.html`
