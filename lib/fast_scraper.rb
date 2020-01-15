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
    @doc = Nokogiri::HTML(URI.open(@page_url))
  end

  def title
    @doc.xpath("//span[@id='what_container']//input//attribute::value").to_s.capitalize +
      ' jobs at ' +
      @doc.xpath("//span[@id='where_container']//input//attribute::value").to_s.capitalize
  end

  def url_name
    arr = (@doc.css "div[@class='title']//a").to_a
    [arr.map { |x| x.css('text()').to_s }, arr.map { |x| @in_job_url + x.xpath('attribute::href').to_s }]
  end

  private

  def webpage(url)
    Nokogiri::HTML(URI.open(url))
  end
end
