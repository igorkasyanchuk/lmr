module Admin
  class ServiceProvidersController < DashboardController
    actions :all, :except => :show
    defaults :resource_class => ServiceProvider, :collection_name => 'service_provider', :instance_name => 'service_provider'
    before_filter :admin_required

    def index
      @service_provider = if params[:q].present? 
          ServiceProvider.where("email like :q or name like :q or district like :q or code like :q", :q => "%" + params[:q] + "%")
        else
          ServiceProvider
        end.order(:district).includes(:responsible_persons).page(params[:page]).per(10)
    end

  end
end
