class Role < ActiveRecord::Base
  has_many :users
  attr_accessible :name

  def self.[](name)
    find_or_create_by_name(name)
  end   
end