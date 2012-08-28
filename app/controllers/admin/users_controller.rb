class Admin::UsersController < Admin::DashboardController
  before_filter :admin_required

  def create
    create! {[:admin, :users]}
  end

  def update
    update! {[:admin, :users]}
  end

end