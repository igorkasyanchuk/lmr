class Consumer < ActiveRecord::Base
	belongs_to :house
	has_one :user
	attr_accessible :code, :description, :deleted, :house_id, :flat, :entrance, :floor, :letter, :calc_area, :heat_area, :numbrsdn, :numbmgst

end