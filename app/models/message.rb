class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :from
  belongs_to :conversation
end
