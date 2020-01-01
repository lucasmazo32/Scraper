# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Scraper

  attr_reader :in_job_url
    
  def initialize
    @page_url = 'https://www.indeed.com/q-back-end-developer-l-United-States-jobs.html'
    @in_job_url = 'https://www.indeed.com/jobs?q=back%20end%20developer&l=United%20States&vjk='
    @doc = Nokogiri::HTML(open(@page_url))
  end

  def webpage(url)
    new_page = Nokogiri::HTML(open(url))
  end

  def table_creation(name, par = nil)
    table = [name]
    text = table_text(par)
    (0...text.length / 2).each do |i|
      table[i * 2 + 1] = '----------------'
      table[i * 2 + 2] = "#{text[i * 2]} #{text[i * 2 + 1]}"
    end
    table
  end

  def table_text(n = nil)
    if n == 1
      @doc.xpath("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
    elsif n == 2
      @doc.xpath("//div[@id='rb_Job Type']//li//span[@class]/text()")
    else
      @doc.xpath("//div[@id='rb_Location']//li//span[@class]/text()")
    end
  end

  def get_ext
    @doc.xpath('//div//attribute::data-jk')
  end

  def job_link(num)
    @in_job_url + get_ext[num].to_s
  end
end

s1 = Scraper.new

for i in 0...s1.get_ext.length do
puts s1.job_link(i)
end