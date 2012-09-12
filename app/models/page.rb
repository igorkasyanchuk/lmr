class Page < ActiveRecord::Base
  attr_accessible :title, :content, :identifier, :seo_title, :seo_keywords, :seo_description

  #validates :title, :presence => true
  validates :identifier, :uniqueness => true, :presence => true

  before_save :downcase_identifier

  #before_save :populate_url_title

  #def populate_url_title
  #  self.url_title = if title.present? 
  #    Ukrainian::Transliteration.transliterate(title)
  #  else
  #    identifier
  #  end
  #end

  def downcase_identifier
    self.identifier = self.identifier.downcase.gsub(/[^0-9a-z]/i, '') if self.identifier.present?
  end

  def self.[] identifier
    page = Page.find_or_initialize_by_identifier(identifier)

    if page.new_record?
      page.permanent = true
      page.save(:validate => false)
    end
    page
  end


end
