class PagePart < ActiveRecord::Base
  attr_accessible :content, :identifier, :format, :page_part

  FORMATS = ['html', 'text']

  validates_uniqueness_of :identifier
  validates_presence_of :identifier

  def self.[](identifier)
    page_part = PagePart.find_by_identifier(identifier)
    page_part = PagePart.create(:identifier => identifier, :content => "") unless page_part
    page_part
  end

  def safe_content?
    ['text'].include?(self.format)
  end
end
