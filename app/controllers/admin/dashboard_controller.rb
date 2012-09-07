# encoding: utf-8
class Admin::DashboardController < InheritedResources::Base
  layout 'admin'

  before_filter :authenticate_user!
  before_filter :verify_user_is_active
  before_filter :admin_or_moderator_required

  def welcome
  end

  protected
    def admin_required
      redirect_to root_path, :notice => 'Ви повинні бути адміністратором.' unless current_user.admin?
    end

    def admin_or_moderator_required
      redirect_to root_path, :notice => 'У вас недостатньо прав.' if !(current_user.admin? || current_user.content_manager?)
    end

end
