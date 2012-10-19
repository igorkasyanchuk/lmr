class SessionsController < Devise::SessionsController
  before_filter :expire_consumer_info, :only => [:destroy]
  after_filter :expire_consumer_info, :only => [:create]

  def expire_consumer_info
    Rails.cache.delete("consumer_info_#{current_user.identifier}") if Rails.cache.exist?("consumer_info_#{current_user.identifier}")
  end
end