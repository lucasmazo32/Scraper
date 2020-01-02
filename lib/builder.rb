require 'nokogiri'
require_relative './scraper.rb'

class Builder

    def initialize
        @doc = Nokogiri::HTML(File.open("index.html"))
    end

    def doc(cont)
        for i in 0...6 do
            li = @doc.at_css "div[@class='city-1 col-3 d-flex justify-content-center']//ul//li#{[i+1]}"
            li.content = cont[i]
        end
        @doc.to_html
    end
end

b1 = Builder.new
s1 = Scraper.new

File.delete("test.html")
file = File.new("test.html",'w')
file.write(b1.doc(s1.table_creation('Salary Estimate', 1, s1.page_url)))
file.close

puts `xdg-open test.html`
