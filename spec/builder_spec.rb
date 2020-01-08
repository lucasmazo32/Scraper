# frozen_string_literal: true

require_relative('../lib/builder.rb')

describe Builder do
  buil = Builder.new
  describe '#page_title' do
    it 'returns Basic scrap if you put one' do
      expect(buil.page_title(1)).to eql('Basic Scrap')
    end
    it 'returns Advanced scrap if you do not put anything' do
      expect(buil.page_title).to eql('Advanced Scrap')
    end
  end

  describe '#hyperlink' do
    it 'modifies the hiperlink, should returns the href of the title I give' do
      expect(buil.hyperlink('https://www.indeed.com', 'search-title')).to eql('https://www.indeed.com')
    end
  end

  describe '#job_data' do
    it 'modifies the Unorder list items, it should return (0...6)' do
      expect(buil.job_data([1, 2, 3, 4, 5, 6], 4, 'main', 'sal')).to eql(0...6)
    end
  end

  describe '#fast_jobs' do
    it 'modifies the unorder list items for fast scrap, should return a message for the user to wait' do
      expect(buil.fast_jobs([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])).to eql('Give us '\
        'a moment to load a more thorough scrap (and be patient, it can take up to 1 minute).'\
        ' Meanwhile, check these hot jobs!')
    end
  end

  describe '#jobs' do
    it 'adds the jobs with hiperlink to the html file, should return (0...5)' do
      expect(buil.jobs([1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], 'city1')).to eql(0...5)
    end
  end

  describe '#title' do
    it 'modifies the title of a city or main page, should return first imput' do
      expect(buil.title('This', 'city2-title')).to eql('This')
    end
  end

  describe '#trans_html' do
    it 'converts the modified document into html' do
      expect(buil.trans_html).to eql(buil.doc.to_html)
    end
  end
end
