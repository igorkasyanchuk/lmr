class Admin::ContactsController < Admin::DashboardController
  defaults :resource_class => Contact, :collection_name => 'contacts', :instance_name => 'contact'
  before_filter :admin_required
end