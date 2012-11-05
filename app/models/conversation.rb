class Conversation < ActiveRecord::Base
  attr_accessible :service_provider_id, :token, :user_id, :body, :subject
  attr_accessor :body
  belongs_to :user
  belongs_to :service_provider
  has_many :messages

  validates_presence_of :service_provider_id, :token, :user_id, :body, :subject

  before_validation :add_token
  after_create :send_initial_message

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

end
