# encoding: utf-8
class Admin::ProfilesController < Admin::DashboardController
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    # protect user
    params[:user].delete(:role_id)
    if @user.update_with_password(params[:user])
      redirect_to '/admin', :notice => "Ваш профіль успішно оновлено"
    else
      render :edit
    end
  end
end