# frozen_string_literal: true

require_relative('../lib/fast_scraper.rb')

describe Fast do
  fastsc = Fast.new
  describe '#title' do
    it 'gives you the title of the page' do
      expect(fastsc.title).to be_a String
    end
  end

  describe '#url_name' do
    it 'gives you the name and url of the jobs in a 2d array' do
      expect(fastsc.url_name.length).to eql(2)
    end
  end
end
