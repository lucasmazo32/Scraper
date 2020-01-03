# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Fast
  attr_reader :in_job_url
  attr_reader :page_url
  attr_reader :doc

  # Initial values
  def initialize(page_url = 'https://www.indeed.com/q-back-end-developer-l-United-States-jobs.html')
    @page_url = page_url
    @in_job_url = 'https://www.indeed.com'
    @doc = Nokogiri::HTML(open(@page_url))
  end

  def webpage(url)
    new_page = Nokogiri::HTML(open(url))
  end

  # Creates a table with the given array. It gives it a #name, it requires a parameter, give 1 to Salary Estimate,
  # 2 for Job Type and else for location, and the link for the webpage you want to create it from.
  def table_creation(name, par = nil)
    table = [name]
    text = table_text(par)
    (0...text.length / 2).each do |i|
      table[i + 1] = "#{text[i * 2]} #{text[i * 2 + 1]}"
    end
    table
  end

  # It gives the array needed with two parameters, n, 1 for Salary, 2 for Job type and 3 for Location and the Link of the page
  def table_text(n = nil)
    if n == 1
      arr = @doc.css("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
      arr = webpage(@page_url).css("//div[@id='rb_Salary Estimate']//li//span[@class]/text()") while arr.empty?
    elsif n == 2
      arr = @doc.xpath("//div[@id='rb_Job Type']//li//span[@class]/text()")
      arr = webpage(@page_url).css("//div[@id='rb_Job Type']//li//span[@class]/text()") while arr.empty?
    else
      arr = @doc.xpath("//div[@id='rb_Location']//li//span[@class]/text()")
      arr = webpage(@page_url).css("//div[@id='rb_Location']//li//span[@class]/text()") while arr.empty?
    end
    arr
  end

  def get_url_name
    arr = (@doc.css "div[@class='title']//a").to_a
    result = [arr.map { |x| x.css("text()").to_s } , arr.map { |x| @in_job_url + x.xpath("attribute::href").to_s }]
  end
end

f1 = Fast.new

puts f1.get_url_name
