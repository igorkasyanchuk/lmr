class Conversation < ActiveRecord::Base
  attr_accessible :service_provider_id, :token, :user_id, :body, :subject
  attr_accessor :body
  belongs_to :user
  belongs_to :service_provider
  has_many :messages

  validates_presence_of :service_provider_id, :token, :user_id, :body, :subject

  before_validation :add_token
  after_save :create_message

  private
  
  def add_token
    self.token = SecureRandom.hex(10)    
  end

  def create_message
    self.messages << Message.create(body: self.body, from: self.user.full_name)
  end

end