# frozen_string_literal: true

require_relative('../lib/scraper.rb')

describe Scraper do
    scrap = Scraper.new
    describe '#search_title' do
      it 'returns the title of the page' do
          expect(scrap.search_title).to be_a String
      end
    end

    describe '#table_creation' do
        it 'creates a table for further use containing specific information' do
            expect(scrap.table_creation('Salary Estimate', scrap.page_url, 1)).to be_a Array
        end      
    end

    describe '#loc_link' do
      it 'creates an array of 3 spaces of links' do
          expect(scrap.loc_link.length).to eql(3)
      end
    end

    describe '#city' do
      it 'returns an array of the most important cities' do
          expect(scrap.city).to be_a Array
      end
    end

    describe '#first' do
      it 'gives you the link of the first 5 jobs' do
          expect(scrap.first(0)[1].match?('https://www.indeed.com')).to be true
      end
    end

    describe '#yoe' do
      it 'gives you the years of experience and name of job per job in a 2d array' do
          expect(scrap.yoe(0).length).to eql(2)
      end
    end
end