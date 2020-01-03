# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'watir'
require 'webdrivers'

class Safe
    attr_reader :in_job_url
    attr_reader :page_url
    attr_reader :doc
    attr_reader :local
  
    # Initial values
    def initialize
      @page_url = 'https://www.indeed.com/q-back-end-developer-l-United-States-jobs.html'
      @in_job_url = 'https://www.indeed.com'
      @doc = Nokogiri::HTML.parse(open(@page_url))
      @file = File.new("./html/noko_local.html","w")
      @file.write(@doc.to_html)
      @local = Nokogiri::HTML(File.open("./html/noko_local.html"))
    end

    def webpage(url)
        new_page = Nokogiri::HTML(open(url))
      end

    def create_table
        arr = @local.css("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
        while arr.empty?
            arr = webpage(@page_url).css("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
        end
        arr
    end

    def ver
        puts '-----------------------'
        arr = @local.xpath("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
    end
end

#s1 = Safe.new
#
#puts s1.create_table
