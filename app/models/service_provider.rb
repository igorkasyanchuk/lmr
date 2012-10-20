class ServiceProvider < ActiveRecord::Base
  has_and_belongs_to_many :services
  has_many :responsible_persons
  has_one :house


  attr_accessible :code, :name, :phone, :email
end
