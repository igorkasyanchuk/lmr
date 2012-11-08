class ServiceProvidersController < ApplicationController

  def index
    @service_providers = ServiceProvider.all.group_by{ |sp| sp.district }.sort
  end
end