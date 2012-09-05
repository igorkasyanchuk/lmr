class Consumer < ActiveRecord::Base
	belongs_to :house
	has_one :user
end