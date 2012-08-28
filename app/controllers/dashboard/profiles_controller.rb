# encoding: utf-8
class Dashboard::ProfilesController < Dashboard::DashboardController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    # protect user
    params[:user].delete(:role_id)
    if @user.update_attributes(params[:user])
      redirect_to '/dashboard', :notice => "Успішно оновлено"
    else
      render :edit
    end
  end
end