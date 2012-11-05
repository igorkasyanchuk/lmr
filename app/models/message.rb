class Message < ActiveRecord::Base
  attr_reader :recipients
  attr_accessible :body, :conversation_id, :from, :recipients, :history
  belongs_to :conversation
  validates_presence_of :body, :conversation_id, :from

  def subject_token
    "#{self.conversation.subject} - [#{self.conversation.token}]"
  end

  def subject
    "#{conversation.subject} (#{conversation.token})"
  end

  def mail!
    ConversationMailer.message(self).deliver
  end

  def body_with_history
    [body, history].join('<hr>')
  end

  def history
    conversation.history
  end

end