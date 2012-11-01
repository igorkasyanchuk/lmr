# encoding: utf-8
class Post < ActiveRecord::Base

  mount_uploader :preview, PostPreviewUploader

  attr_accessible :title, :description, :content, :post_category_id, :published, :preview, :links, :posted_by

  belongs_to :post_category

  validates :title, :presence => true, :length => {:in => 3..255}
  validates :description, :presence => true
  validates :content, :presence => true
  validates_uniqueness_of :title, :scope => :post_category_id

  scope :recent, order("id DESC")
  scope :last_five, where(:published => true).order("id DESC").limit(5)
  scope :published, recent.where(:published => true)
  scope :by_date, order("created_at DESC")
  scope :by_category, lambda { |id| where(:category_id => id ) }
end