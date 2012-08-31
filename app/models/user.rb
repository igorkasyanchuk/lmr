class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :identifier, :name, :surname, :login, :role_id
  attr_accessor :login
  
  validates_presence_of :identifier, :name, :surname
  validates_uniqueness_of :identifier
  validates :name, :surname, :length => { :minimum => 2 }

  belongs_to :role

  delegate :name, :to => :role, :allow_nil => true, :prefix => true

  before_create :set_defaults

  def set_defaults
    self.role = Role['user']
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(:blocked => false).where(["lower(identifier) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).where(:blocked => false).first
    end
  end

  ["admin", "content_manager", "user"].each do |role_name|
    define_method "#{role_name}?" do
      has_role?(role_name)
    end
  end

  def has_role?(role)
    self.role && self.role.name == role
  end

  def full_name
    "#{name} #{surname}"
  end

  def forum_blocked?
    self.forem_state == 'spam'
  end

  def forem_admin?
    self && (self.admin? || self.content_manager?) && !self.forum_blocked?
  end

end