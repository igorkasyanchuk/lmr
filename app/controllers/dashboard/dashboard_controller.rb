class Dashboard::DashboardController < InheritedResources::Base
  layout 'dashboard'

  before_filter :authenticate_user!
  before_filter :verify_user_is_active
  
  def welcome
  end

  def pay_services
  end

end
