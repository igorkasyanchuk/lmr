class Page < ActiveRecord::Base
  attr_accessible :title, :content

  #validates :title, :presence => true
  validates :identifier, :uniqueness => true, :presence => true

  #before_save :populate_url_title

  #def populate_url_title
  #  self.url_title = if title.present? 
  #    Ukrainian::Transliteration.transliterate(title)
  #  else
  #    identifier
  #  end
  #end

  def self.[] identifier
    page = Page.find_or_initialize_by_identifier(identifier)

    if page.new_record?
      page.permanent = true
      page.save(:validate => false)
    end
    page
  end


end
