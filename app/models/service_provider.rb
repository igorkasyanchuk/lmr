class ServiceProvider < ActiveRecord::Base
  attr_accessible :code, :names, :phone, :email, :address, :responsible_persons_attributes, :name, :district

  has_many :responsible_persons, :dependent => :destroy
  has_one :house
  has_many :conversations

  validates_presence_of :name, :address, :district

  accepts_nested_attributes_for :responsible_persons, :reject_if => lambda { |a| a[:first_name].blank? && a[:last_name].blank? }, :allow_destroy => true
  
end
