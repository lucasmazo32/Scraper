# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Scraper
  attr_reader :in_job_url
  attr_reader :page_url
  attr_reader :doc

  # Initial values
  def initialize
    @page_url = 'https://www.indeed.com/q-back-end-developer-l-United-States-jobs.html'
    @in_job_url = 'https://www.indeed.com'
    @doc = Nokogiri::HTML(open(@page_url))
  end

  # It gives you the document so you can xpath it. The input is a URL of the page you want the document to be
  def webpage(url)
    new_page = Nokogiri::HTML(open(url))
  end

  # Creates a table with the given array. It gives it a #name, it requires a parameter, give 1 to Salary Estimate,
  # 2 for Job Type and else for location, and the link for the webpage you want to create it from.
  def table_creation(name, par = nil, link)
    table = [name]
    text = table_text(par, link)
    (0...text.length / 2).each do |i|
      table[i * 2 + 1] = '----------------'
      table[i * 2 + 2] = "#{text[i * 2]} #{text[i * 2 + 1]}"
    end
    table
  end

  # It gives the array needed with two parameters, n, 1 for Salary, 2 for Job type and 3 for Location and the Link of the page
  def table_text(n = nil, link)
    if n == 1
      webpage(link).xpath("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
    elsif n == 2
      webpage(link).xpath("//div[@id='rb_Job Type']//li//span[@class]/text()")
    else
      webpage(link).xpath("//div[@id='rb_Location']//li//span[@class]/text()")
    end
  end

  # It gets the array of all hrefs (/job...) of all the cities. This method is private
  def get_ext
    @doc.xpath("//div[@id='rb_Location']//li//a//attribute::href")
  end

  # It converts gives you the link of location with a given number (0...5), you need to pick just one
  def loc_link(num)
    @in_job_url + get_ext[num.to_i].to_s
  end

  # It gives you the link of the job. You will need the extention as a parameter "href"
  def job_link(href)
    @in_job_url + href
  end

  # Gives you the Nokogiri document for further use (5 first). It require the number of the city you want to analize
  def doc_of_job(city_number)
    arr = []
    (0...5).each do |i|
      arr[i] = webpage(job_link(first(loc_link(city_number))[1][i]).to_s).xpath("//div[@id='jobDescriptionText']")
    end
    arr
  end

  # This gets the name of the city with the city link. To make it work you need the city number
  def city(city_number)
    webpage(loc_link(city_number)).xpath("//span[@class='item']//b//text()")
  end

  # Gives you the name of the first 10 jobs and refs in a 2d array, you need the number of the city
  def first(city_num)
    result = []
    result = [webpage(loc_link(city_num)).xpath("//div[@class='title']//a//attribute::title"), webpage(loc_link(city_num)).xpath("//div[@class='title']//a//attribute::href")]
  end

  # Gives you the years of experience required for the job
  def yoe
    first
  end
end
