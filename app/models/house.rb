class House < ActiveRecord::Base
	has_many :consumers
	belongs_to :firm
	belongs_to :street
	attr_accessible :id, :description, :deleted, :firm_id, :street_id, :number_code, :letter
end