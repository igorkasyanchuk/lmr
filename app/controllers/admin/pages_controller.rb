module Admin
  class PagesController < DashboardController

    actions :all, :except => :show
    before_filter :admin_required
    defaults :resource_class => Page

    def index
      @pages = Page.page(params[:page]).per(20)
    end

  end
end
