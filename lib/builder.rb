# frozen_string_literal: true

require 'nokogiri'

class Builder
  attr_reader :doc

  def initialize
    @doc = Nokogiri::HTML(File.open('./html/index.html'))
  end

  def page_title(num = nil)
    title = @doc.at_css 'title'
    title.content = (num == 1 ? 'Basic Scrap' : 'Advanced Scrap')
  end

  # Adds the hiperlink to the title. Needs the URL and the class name as inputs
  def hyper(url, class_name)
    hyper_a = @doc.at_css "div[@class='row title #{class_name}']//a"
    hyper_a['href'] = url
  end

  # Modifies the Un-ordered list with the content given (array), column of bootstrap and class name
  def lis(cont, col, class_container, class_name)
    (0...6).each do |i|
      li = @doc.at_css "div[@class='row #{class_container}']//div[@class='#{class_name} col-#{col} d-flex justify-content-center']//ul//li#{[i + 1]}"
      li.content = cont[i]
    end
  end

  def fast(cont, hyper)
    (0...10).each do |i|
      li = @doc.at_css "div[@class='row fast justify-content-center']//ul//li#{[i + 1]}//a"
      li.content = cont[i]
      li['href'] = hyper[i]
    end
    div = @doc.at_css "div[@class='row title city1-title']"
    div.content = 'Give us a moment to load a more thorough scrap (and be patient, it can take up to 1 minute). Meanwhile, check these hot jobs!'
  end

  def jobs(job_name, years, hyper, city_num)
    (0...5).each do |i|
      li = @doc.at_css "div[@class='#{city_num}-jobs col-12 d-flex justify-content-center']//ul//li#{[i * 2 + 1]}//a"
      yoe = @doc.at_css "div[@class='#{city_num}-jobs col-12 d-flex justify-content-center']//ul//li#{[i * 2 + 2]}"
      li.content = job_name[i]
      yoe.content = years[i]
      li['href'] = hyper[i]
    end
  end

  # Puts the title. Needs the content and the class name
  def title(cont, class_name)
    div = @doc.at_css "div[@class='row title #{class_name}']//a"
    div.content = cont
  end

  # Converts the document to HTML for further use
  def trans_html
    @doc.to_html
  end
end
