class House < ActiveRecord::Base
	has_many :consumers
	belongs_to :firm
	belongs_to :street
end