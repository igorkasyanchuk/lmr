class Street < ActiveRecord::Base
	has_many :houses
	attr_accessible :id, :name, :deleted
end