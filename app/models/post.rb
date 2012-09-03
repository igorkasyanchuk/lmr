class Post < ActiveRecord::Base

  mount_uploader :preview, PostPreviewUploader

  attr_accessible :title, :description, :content, :post_category_id, :published, :preview

  belongs_to :post_category

  validates :title, :presence => {:message => "Please enter title"}, :length => {:in => 3..255}
  validates :description, :presence => true
  validates :content, :presence => true
  validates_uniqueness_of :title, :scope => :post_category_id

  scope :recent, order("id DESC")
  scope :published, recent.where(:published => true)
  scope :by_date, order("created_at DESC")
  scope :by_category, lambda { |id| where(:category_id => id ) }
end