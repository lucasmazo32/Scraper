require 'nokogiri'
require 'open-uri'

class Scraper
    def initialize
        @doc = Nokogiri::HTML(open('https://www.indeed.com/jobs?q=back+end+developer&l=United+States'))
    end

    def table_creation(name, par = nil)
        table = [name]
        text = table_text(par)
        for i in 0...text.length/2 do
            table[i*2 + 1] = '----------------'
            table[i*2 + 2] = "#{text[i*2].to_s} #{text[i*2 +1].to_s}"
        end
        table
    end

    def table_text(n = nil)
        if n==1
            @doc.xpath("//div[@id='rb_Salary Estimate']//li//span[@class]/text()")
        elsif n==2
            @doc.xpath("//div[@id='rb_Job Type']//li//span[@class]/text()")
        else
            @doc.xpath("//div[@id='rb_Location']//li//span[@class]/text()")
        end
    end
end
