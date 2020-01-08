# Scraper - Capstone project

## Instructions

- Before running the program, make sure to install the dependencies!

- To run this file you have to open a terminal to the main folder and type "bin/main.rb" without quotation marks.

- Afterwards, the program is going to ask you if you want to submit a file from a webpage or run the default.

- If you decide to continue with the default page (Back End Developer jobs at U.S.), just press enter and enjoy.

- If you decide to enter a webpage, I encourage you to visit [indeed](https://www.indeed.com/jobs?q=full+stack+developer&l=United+States) and search for what you want, copy the link (all of it!) and paste it in the terminal. 

- It will check if the page has the desired syntax. If it's good, just enjoy!

- P.S. When the file starts running, a basic scrap of the jobs will be prompted in a GUI in your web browser. After 1 minute (or so) a more thorough scrap will appear in another tab. It will have more descriptive information about the search you just made!

- BOTH files will automatically load. Therefore there is no need to go back to the code once the first page is loaded.

# About the file

## What should you expect when running the program

You will get the information of:

- Ten jobs in the fast scraper page with their respective hyperlink.
- The information of estimated salary, type of contract and most important cities for employment in the U.S.
- The report of estimated wage, type of contract, five jobs with years of experience (if given) and their respective hyperlink for the three most important cities in the U.S. for the given position.

## Why Indeed?

Is a page that I generally use to look up for jobs, so it will be useful for me in the future.

## What does it contain?

It has 4 Ruby files, in which I run the program to interact with the user, to scrap thorough information about a webpage, to scrap basic information about a webpage and one to create the GUI. I have one HTML main file (index.html) from which the pages are created. I also have two files, one for reset and the other one to give the page a basic layout. Since the focus of the project was NOT CSS or HTML, I just created a basic layout using bootstrap.

## Why a GUI?

I figured out that this program can be useful to people different than programmers, so a GUI is necessary for them to understand what is going on or what the result is. Also, it is easier to see once you get the graphic input of what you have done.

## Learnings

This project gave me a deeper understanding of the concepts in ruby and it was great to develop a real-world solution to a specific problem. I faced some challenges in the way which make me more conscious about the details. For instance, I found out that Nokogiri, or any web parser for that matter, do not work well with dynamic websites, and since indeed has a dynamic page, in some methods I had to load the page multiple times, thus creating a much more slower file, being this the main reason of why I have a fast scraper, that gives you a basic scrap of the page in less than two seconds, and a more thorough but slow one that gives you deeper information of your search, taking about 1 minute to complete.

## Built With

- Ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]
- Gems: Nokogiri
- HTML
- CSS
- VSCode

## Live Demo
You can check the live version here: **pending**

## Author

👤 **Lucas Mazo**
- Github: [@lucasmazo32](https://github.com/lucasmazo32)
- Twitter: [@lucasmazo32](https://twitter.com/lucasmazo32)
- Linkedin: [Lucas Mazo](https://www.linkedin.com/in/lucas-mazo-meza-55a65b159/)