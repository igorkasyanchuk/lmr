# encoding: utf-8
class Conversation < ActiveRecord::Base
  attr_accessible :service_provider_id, :token, :user_id, :body, :subject
  attr_accessor :body
  belongs_to :user
  belongs_to :service_provider
  has_many :messages

  validates_presence_of :service_provider_id, :token, :user_id, :body, :subject
  validate :service_provider_email

  before_validation :add_token
  after_create :send_initial_message

  def self.receive_mail(message)
    token = get_token_from_subject message.subject
    conversation = Conversation.find_by_token(token) if token
    if conversation #&& (conversation.user.email == message.from.first || conversation.service_provider.email == message.from.first)
      conversation.reply_with_email message
    end
  end

  def self.get_token_from_subject subject
   subject[/\(([a-z0-9]+)\)$/, 1] 
  end

  def reply_with_email message
    recipient = if user.email != message.from.first
      [user.email]
    else
      [service_provider.email]
    end
    messages.create(body: get_decoded_message_body(message), from: message.from, recipients: [recipient]).mail!
  end

  def get_decoded_message_body message
    (message.text_part || message.html_part || message).body.decoded.force_encoding('UTF-8')
  end

  def strip_history text
    messages.each { |m| text = text.gsub(m.body, '') }
    text
  end
  
  def reply_with_form params
    messages.create(body: params[:body], recipients: [user.email, service_provider.email], from: user.full_name).mail!
  end

  def history
    messages.map(&:body).join('<hr>')
  end

  private

  def add_token
    self.token = SecureRandom.hex(10)    
  end

  def send_initial_message
    self.messages.create(body: self.body, recipients: [self.user.email, self.service_provider.email], from: user.full_name).mail!
  end

  def service_provider_email
    unless self.service_provider.email.match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i)
      errors.add :service_provider_id, 'Вибрана організація не вказала електронну пошту для запитів'
    end
  end

end
