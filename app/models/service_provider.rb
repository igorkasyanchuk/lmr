class ServiceProvider < ActiveRecord::Base
  has_many :responsible_persons, :dependent => :destroy
  has_one :house


  accepts_nested_attributes_for :responsible_persons
  attr_accessible :code, :names, :phone, :email, :address, :responsible_persons_attributes, :name, :district
end
