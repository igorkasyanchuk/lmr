class Admin::DashboardController < InheritedResources::Base
  layout 'admin'

  before_filter :authenticate_user!   
  
  def welcome
  end

  protected
    def admin_required
      true
    end

end
