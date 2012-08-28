class Admin::ContactsController < Admin::DashboardController
  before_filter :admin_required
end