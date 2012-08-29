class Admin::UsersController < Admin::DashboardController
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  before_filter :admin_required

  def update
    update! {[:admin, :users]}
  end

  def destroy
  	destroy! {[:admin, :users]}
  end

end