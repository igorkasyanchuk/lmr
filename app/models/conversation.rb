class Conversation < ActiveRecord::Base
  attr_accessible :service_provider_id, :token, :user_id, :body, :subject
  attr_accessor :body
  belongs_to :user
  belongs_to :service_provider
  has_many :messages

  validates_presence_of :service_provider_id, :token, :user_id, :body, :subject

  before_validation :add_token
  after_save :create_message

  def self.receive_mail(message)
    token = message.subject[/\[(.*?)\]/, 1]
    conversation = Conversation.find_by_token(token) if token
    if conversation && (conversation.user.email == message.from.first || conversation.service_provider.email == message.from.first)
      conversation.messages.create body: message.body.decoded, from: message.from.first
    end
  end
  
  def reply_with_form params
    messages.create body: params[:body], recipients: [user.email, service_provider.email]
  end

  def history
    messages.map(&:body).join('<hr>')
  end

  private

  def add_token
    self.token = SecureRandom.hex(10)    
  end

  def create_message
    self.messages << Message.create(body: self.body, from: self.user.email)
  end

end
