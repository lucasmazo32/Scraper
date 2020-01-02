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

end