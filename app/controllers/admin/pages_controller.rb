module Admin
  class PagesController < DashboardController
    before_filter :admin_required
    defaults :resource_class => Page

  end
end
