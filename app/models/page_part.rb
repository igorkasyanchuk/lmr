class PagePart < ActiveRecord::Base
  attr_accessible :content, :identifier, :format, :page_part, :plain_text, :html_text, :do_update

  FORMATS = ['html', 'text']

  validates_uniqueness_of :identifier
  validates_presence_of :identifier

  attr_accessor :plain_text, :html_text, :do_update

  before_save :update_content

  def update_content
    if self.format == 'text' 
      self.content = self.plain_text
    else
      self.content = self.html_text
    end if self.do_update.present?
  end

  def self.[](identifier)
    page_part = PagePart.find_by_identifier(identifier)
    page_part = PagePart.create(:identifier => identifier, :content => "") unless page_part
    page_part
  end

  def safe_content?
    ['text'].include?(self.format)
  end
end
