class House < ActiveRecord::Base
	has_many :consumers
	has_one :service_provider
	belongs_to :street
	attr_accessible :id, :description, :deleted, :service_provider_id, :street_id, :number_code, :letter
end