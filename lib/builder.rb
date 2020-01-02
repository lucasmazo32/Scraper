require 'nokogiri'
require_relative './scraper.rb'

class Builder

    attr_reader :doc

    def initialize
        @doc = Nokogiri::HTML(File.open("index.html"))
    end

    #Adds the hiperlink to the title. Needs the URL and the class name as inputs
    def hyper(url, class_name)
        hyper_a = @doc.at_css "div[@class='row title #{class_name}']//a"
        hyper_a['href'] = url
    end

    #Modifies the Un-ordered list with the content given (array), column of bootstrap and class name
    def lis(cont,col,class_container ,class_name)
        for i in 0...6 do
            li = @doc.at_css "div[@class='row #{class_container}']//div[@class='#{class_name} col-#{col} d-flex justify-content-center']//ul//li#{[i+1]}"
            li.content = cont[i]
        end
    end

    def jobs(job_name, years, hyper, city_num)
        for i in 0...5 do
            li = @doc.at_css "div[@class='#{city_num}-jobs col-6 d-flex justify-content-center']//ul//li#{[i*2 +1]}//a"
            yoe = @doc.at_css "div[@class='#{city_num}-jobs col-6 d-flex justify-content-center']//ul//li#{[i*2 +2]}"
            li.content = job_name[i]
            yoe.content = years[i]
            li['href']=hyper[i]
        end
    end

    # Puts the title. Needs the content and the class name
    def title(cont, class_name)
        div = @doc.at_css "div[@class='row title #{class_name}']//a"
        div.content = cont
    end

    #Converts the document to HTML for further use
    def to_html
        @doc.to_html
    end
end

b1 = Builder.new
s1 = Scraper.new

search_title = s1.search_title # Title of the page
main_url = s1.page_url  # Page url
city_link = s1.loc_link # Cities URL's
city = s1.city          # Cities Name
salary_main = s1.table_creation('Salary Estimate', 1, s1.page_url) # Table of the main page
job_main = s1.table_creation('Job Type', 2, s1.page_url)           # Table of the main page
loc_main = s1.table_creation('Location', nil, s1.page_url)           # Table of the main page
salary_city2 = s1.table_creation('Salary Estimate',1,city_link[1])  #Table for cities
salary_city1 = s1.table_creation('Salary Estimate',1,city_link[0])  #Table for cities
salary_city3 = s1.table_creation('Salary Estimate',1,city_link[2])  #Table for cities
job_city1 = s1.table_creation('Job Type',2,city_link[0])  #Table for cities
job_city2 = s1.table_creation('Job Type',2,city_link[1])  #Table for cities
job_city3 = s1.table_creation('Job Type',2,city_link[2])  #Table for cities

jobs_link_city1 = s1.first(0)
jobs_link_city2 = s1.first(1)
jobs_link_city3 = s1.first(2)
yoe1 = s1.yoe(0)
yoe2 = s1.yoe(1)
yoe3 = s1.yoe(2)

File.delete("test.html")
file = File.new("test.html",'w')
b1.hyper(main_url, 'search-title')
b1.hyper(city_link[0], 'city1-title')
b1.hyper(city_link[2], 'city2-title')
b1.hyper(city_link[1], 'city3-title')
b1.title(search_title, 'search-title')
b1.title(city[0], 'city1-title')
b1.title(city[1], 'city2-title')
b1.title(city[2], 'city3-title')
b1.lis(salary_main,4,'main','sal')
b1.lis(job_main,4,'main','job')
b1.lis(loc_main,4,'main','loc')
b1.lis(salary_city1,3,'city1','sal')
b1.lis(salary_city2,3,'city2','sal')
b1.lis(salary_city3,3,'city3','sal')
b1.lis(job_city1,3,'city1','job')
b1.lis(job_city2,3,'city2','job')
b1.lis(job_city3,3,'city3','job')
b1.jobs(yoe1[0], yoe1[1], jobs_link_city1, 'city1')
b1.jobs(yoe2[0], yoe2[1], jobs_link_city2, 'city2')
b1.jobs(yoe3[0], yoe3[1], jobs_link_city3, 'city3')
file.write(b1.to_html)
file.close

puts `xdg-open test.html`
