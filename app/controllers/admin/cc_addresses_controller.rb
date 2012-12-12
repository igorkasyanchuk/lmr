class Admin::CcAddressesController < Admin::DashboardController
  defaults :resource_class => CcAddress, :collection_name => 'cc_addresses', :instance_name => 'cc_address'

  def create
    create! {[:admin, :cc_addresses]}
  end

  def update
    update! {[:admin, :cc_addresses]}
  end
  
end