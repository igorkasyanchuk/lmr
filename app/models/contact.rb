class Contact < ActiveRecord::Base
  apply_simple_captcha
  
  validates :name, :presence => true, :length => {:in => 5..200}
  validates :email,
              :presence => true,
              :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :on => :create
  validates :message, :presence => true
end
