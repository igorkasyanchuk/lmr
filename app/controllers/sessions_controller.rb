class SessionsController < Devise::SessionsController
  before_filter :expire_consumer_info, :only => [:destroy]
  after_filter :expire_consumer_info, :only => [:create]

  def expire_consumer_info
    set_user_identifier
    Rails.cache.delete("consumer_info_#{current_user.identifier}")
  end

  def set_user_identifier
    current_user.identifier = 4110000106052 if current_user
  end
end