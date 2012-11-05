class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :from
  belongs_to :conversation
  validates_presence_of :body, :conversation_id, :from

  def subject_token
    "#{self.conversation.subject} - [#{self.conversation.token}]"
  end

end