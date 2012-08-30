class PostCategory < ActiveRecord::Base
  has_many :posts

  scope :by_name, order('name asc')
  
end