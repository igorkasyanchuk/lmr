# encoding: utf-8
class Admin::DashboardController < InheritedResources::Base
  layout 'admin'

  before_filter :authenticate_user!
  before_filter :verify_user_is_active
  
  def welcome
  end

  protected
    def admin_required
      redirect_to root_path, :notice => 'Ви повинні бути адміністратором.' unless current_user.admin?
    end

end
