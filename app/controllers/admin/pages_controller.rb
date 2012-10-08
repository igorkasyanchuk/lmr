class Admin::PagesController < Admin::DashboardController
  actions :all, :except => :show
  defaults :resource_class => Page, :finder => :find_by_identifier!

  def index
    @pages = Page.page(params[:page]).per(20)
  end

end
