#encoding: utf-8
class Message < ActiveRecord::Base
  attr_accessor :recipients
  attr_accessible :body, :conversation_id, :from, :recipients, :history
  belongs_to :conversation
  validates_presence_of :body, :conversation_id, :from

  def self.reply params
    conversation.messages.create body: params[:body], from: params[:from], recipients: params[:recipients]
  end

  def subject_token
    "#{self.conversation.subject} - [#{self.conversation.token}]"
  end

  def subject
    "#{conversation.subject} (#{conversation.token})"
  end

  def mail!
    ConversationMailer.new_message(self).deliver
  end

  def body_with_history
    [body, history].join('<hr>')
  end

  def history
    conversation.history
  end

  def user
    conversation.user
  end

  def from_name
    conversation.service_provider.email == from ? conversation.service_provider.name : 'Я'
  end

  def cc_addresses
    CcAddress.pluck(:email)
  end

end
