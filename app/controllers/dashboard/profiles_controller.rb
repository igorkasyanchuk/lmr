# encoding: utf-8
class Dashboard::ProfilesController < Dashboard::DashboardController
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    # protect user
    params[:user].delete(:role_id)
    if @user.update_with_password(params[:user])
      redirect_to '/dashboard', :notice => "Ваш профіль успішно оновлено"
    else
      render :edit
    end
  end
end