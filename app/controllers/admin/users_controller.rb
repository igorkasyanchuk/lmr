class Admin::UsersController < Admin::DashboardController
  before_filter :admin_required
end