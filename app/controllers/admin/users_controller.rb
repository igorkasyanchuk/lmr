# encoding: utf-8

class Admin::UsersController < Admin::DashboardController
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  before_filter :admin_required

  def update
    update! {[:admin, :users]}
  end

  def destroy
  	destroy! {[:admin, :users]}
  end

  def confirm
    resource.confirm!
    redirect_to [:admin, :users], :notice => "Користувача підтвердженно."
  end

  def block
    resource.update_attribute(:blocked, true)
    redirect_to [:admin, :users], :notice => "Користувача заблоковано."
  end

  def unblock
    resource.update_attribute(:blocked, false)
    redirect_to [:admin, :users], :notice => "Користувача розблоковано."
  end

end