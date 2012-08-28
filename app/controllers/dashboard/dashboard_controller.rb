class Dashboard::DashboardController < InheritedResources::Base
  layout 'dashboard'

  before_filter :authenticate_user!   
  
  def welcome
  end

end
