module Admin
  class ServiceProvidersController < DashboardController
    actions :all, :except => :show
    defaults :resource_class => ServiceProvider, :collection_name => 'service_provider', :instance_name => 'service_provider'
    before_filter :admin_required

  end
end
