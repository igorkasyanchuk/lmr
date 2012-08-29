class Post < ActiveRecord::Base

  attr_accessible :title, :description, :content, :post_category_id, :published

  belongs_to :post_category

  validates :title, :presence => {:message => "Please enter title"}, :length => {:in => 3..255}
  validates :description, :length => {:maximum => 1500}
  validates :content, :length => {:maximum => 1500}
  validates_uniqueness_of :title, :scope => :post_category_id

  scope :recent, order("id DESC")
  scope :published, recent.where(:published => true)
  scope :by_date, order("created_at DESC")
  scope :by_category, lambda { |id| where(:category_id => id ) }
end