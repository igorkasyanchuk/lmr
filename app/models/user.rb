class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  mount_uploader :avatar, AvatarUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :identifier, :name, :surname, :login, :role_id, :avatar, :avatar_cache, :remove_avatar, :street, :house, :flat
  attr_accessor :login, :street, :house, :flat
  
  validates_presence_of :identifier, :name, :surname
  validates_uniqueness_of :identifier
  validates :name, :surname, :length => { :minimum => 2 }
  validates :identifier, :length => { :maximum => 13 }
  validates_format_of :identifier, :with => /^\d+$/, :message => :validate_number
  validate :user_identification, :on => :create

  belongs_to :role
  belongs_to :consumer
  has_many :activities, :class_name => "UserActivity", :dependent => :destroy

  delegate :name, :to => :role, :allow_nil => true, :prefix => true

  scope :active, where(:blocked => false)
  scope :blocked, where(:blocked => true)

  before_create :set_defaults

  def set_defaults
    self.role = Role['user']
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).active.where(["lower(identifier) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).active.first
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

  def admin_or_content_manager?
    self.admin? || self.content_manager?
  end

  private

    def user_identification
      c = Consumer.find_by_code(self.identifier)
      unless c and c.flat.to_s == self.flat.to_s and c.house_id.to_i == self.house.to_i and c.house.street_id.to_i == self.street.to_i
        errors[:base] << I18n.t('devise.views.validate_address')
      end

    end

end