require 'nokogiri'
require_relative './scraper.rb'

class Builder

    attr_reader :doc

    def initialize
        @doc = Nokogiri::HTML(File.open("index.html"))
    end

    def lis(cont, class_name)
        for i in 0...6 do
            li = @doc.at_css "div[@class='#{class_name} col-3 d-flex justify-content-center']//ul//li#{[i+1]}"
            li.content = cont[i]
        end
    end

    def to_html
        @doc.to_html
    end
end

b1 = Builder.new
s1 = Scraper.new

File.delete("test.html")
file = File.new("test.html",'w')
b1.lis(s1.table_creation('Salary Estimate', 1, s1.page_url),'sal')
b1.lis(s1.table_creation('Job Type', 2, s1.page_url),'job')
b1.lis(s1.table_creation('City', nil, s1.page_url),'loc')
file.write(b1.to_html)
file.close

puts `xdg-open test.html`
