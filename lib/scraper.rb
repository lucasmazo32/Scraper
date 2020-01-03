# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Scraper
  attr_reader :in_job_url
  attr_reader :page_url
  attr_reader :doc

  # Initial values
  def initialize(page_url = 'https://www.indeed.com/q-back-end-developer-l-United-States-jobs.html')
    @page_url = page_url
    @in_job_url = 'https://www.indeed.com'
    @doc = Nokogiri::HTML(URI.open(@page_url))
  end

  # Gives the name of the search
  def search_title
    arr = []
    arr[0] = @doc.xpath("//span[@id='what_container']//input//attribute::value").to_s.capitalize
    arr[1] = ' jobs at '
    arr[2] = @doc.xpath("//span[@id='where_container']//input//attribute::value").to_s.capitalize
    arr.join
  end

  # Creates a table with the given array. It gives it a #name, it requires a parameter, give 1 to Salary Estimate,
  # 2 for Job Type and else for location, and the link for the webpage you want to create it from.
  def table_creation(name, link, par = nil)
    table = [name]
    text = table_text(link, par)
    (0...text.length / 2).each do |i|
      table[i + 1] = "#{text[i * 2]} #{text[i * 2 + 1]}"
    end
    table
  end

  # It gets the array of all hrefs (/job...) of all the cities. This method is private
  def loc_link
    arr = @doc.xpath("//div[@id='rb_Location']//li//a//attribute::href")
    arr = webpage(@page_url).xpath("//div[@id='rb_Location']//li//a//attribute::href") while arr.empty?
    arr.to_a
    arr[0...3].map { |x| @in_job_url + x.to_s }
  end

  # Gives you the array of the name of 3 most important cities
  def city
    loc_link.map do |x|
      arr = webpage(x).xpath("//span[@class='item']//b//text()")
      arr = webpage(x).xpath("//span[@class='item']//b//text()") while arr.empty?
      arr
    end
  end

  # Gives you the links of the first 5 jobs. You need the number of the city
  def first(city_num)
    result = webpage(loc_link[city_num.to_i]).xpath("//div[@class='title']//a//attribute::href").to_a
    result = result[0...5]
    result.map { |x| job_link(x.to_s) }
  end

  # Gives you the name of the job and years of experience required for the job in a 2d array
  def yoe(city_number)
    arr = []
    arr[0] = webpage(loc_link[city_number]).xpath("//div[@class='title']//a//attribute::title")
    arr[0] = arr[0][0...5]
    arr[1] = doc_of_job(city_number).map { |x| x.select { |y| y if y.include?('years') } }
    arr[1] = arr[1].map { |x| x.empty? ? 'No information given' : x }
    arr
  end

  private

  # It gives the array needed with two parameters, n, 1 for Salary, 2 for Job type and 3 for Location and the Link of the page
  def table_text(link, num = nil)
    if num == 1
      arr = webpage(link).css("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
      arr = webpage(link).css("//div[@id='rb_Salary Estimate']//li//span[@class]/text()") while arr.empty?
    elsif num == 2
      arr = webpage(link).xpath("//div[@id='rb_Job Type']//li//span[@class]/text()")
      arr = webpage(link).css("//div[@id='rb_Job Type']//li//span[@class]/text()") while arr.empty?
    else
      arr = webpage(link).xpath("//div[@id='rb_Location']//li//span[@class]/text()")
      arr = webpage(link).css("//div[@id='rb_Location']//li//span[@class]/text()") while arr.empty?
    end
    arr
  end

  # It gives you the link of the job. You will need the extention as a parameter "href"
  def job_link(href)
    @in_job_url + href
  end

  # Gives you the the text inside the Unorder list. It require the number of the city you want to analize
  def doc_of_job(city_number)
    arr = first(city_number).map { |x| webpage(x).xpath("//div[@id='jobDescriptionText']//ul//text()").to_a }
    arr = arr.map { |x| x.map(&:to_s) }
    arr
  end

  # It gives you the document so you can xpath it. The input is a URL of the page you want the document to be
  def webpage(url)
    Nokogiri::HTML(URI.open(url))
  end
end
