class Contact < ActiveRecord::Base
  apply_simple_captcha
  
  validates :name, :presence => true, :length => {:in => 2..200}
  validates :email,
              :presence => true,
              :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :on => :create
  validates :message, :presence => true

  attr_accessible :name, :email, :message, :captcha, :captcha_key
end
