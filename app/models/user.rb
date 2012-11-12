# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  mount_uploader :avatar, AvatarUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :identifier, :name, :surname, :login, :role_id, :avatar, :avatar_cache, :remove_avatar, :street, :house, :flat, :nickname, :terms
  attr_accessor :login, :street, :house, :flat

  belongs_to :role
  belongs_to :consumer
  has_many :activities, :class_name => "UserActivity", :dependent => :destroy
  has_many :conversations

  delegate :name, :to => :role, :allow_nil => true, :prefix => true

  scope :active, where(:blocked => false)
  scope :blocked, where(:blocked => true)

  validates :name, :surname, :length => { :minimum => 2 }
  validates_presence_of :name, :surname
  validates_format_of :name, :surname, :with => /^[[:alpha:] ]+$/ #/^[\p{Cyrillic} ]+$/
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :nickname, :allow_blank => true

  with_options :if => :is_user? do |user|
    user.validates_presence_of :identifier
    user.validates_presence_of :street, :house, :on => :create
    user.validates_uniqueness_of :identifier
    user.validates :identifier, :length => { :maximum => 13 }
    user.validates_format_of :identifier, :with => /^\d+$/, :message => :validate_number
    user.validate :user_identification, :on => :create, :if => :ready_to_identify?
    user.validates :terms, :acceptance => true, :on => :create
  end

  def is_user?
    role.name == 'user'
  end

  def ready_to_identify?
    street.present? && house.present?
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

  def forum_name
    nickname.present? ? nickname : full_name
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

  def consumer_info
    @consumer_info = Rails.cache.fetch(consumer_info_key) do
      ConsumerInfo[identifier]
    end
    if  @consumer_info.error.present?
      Rails.cache.delete(consumer_info_key)
    end
    @consumer_info
  end

  def service_providers
    ServiceProvider.where :code => consumer_info.service_providers_codes
  end

  def search_address
    "#{consumer_info.street_name.try(:strip)} #{consumer_info.house_number.try(:strip)} #{consumer_info.house_letter.try(:strip)}"
  end

  private

    def user_identification
      consumer = ReportLoader.load_consumer_info(self.identifier)
      address = consumer['address']
      if consumer && address
        street_raw = address['streetCode'].gsub(/\s+/, "") if address['streetCode']
        house_raw = consumer['houseCode'].gsub(/\s+/, "") if consumer['houseCode']
        flat_raw = address['flatNumber'].gsub(/\s+/, "") if address['flatNumber']
        unless street_raw == self.street.to_s && house_raw == self.house.to_s && flat_raw == self.flat.to_s
          errors.add :identifier, I18n.t('devise.views.validate_address')
        end
      else
        errors.add :identifier, "Помилка при звірці даних"
      end
    end

    def consumer_info_key
      "consumer_info_#{identifier}"
    end

end
