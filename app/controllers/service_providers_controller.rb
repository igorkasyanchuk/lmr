class ServiceProvidersController < ApplicationController

  def index
    @service_providers = ServiceProvider.order(:district)
  end
end