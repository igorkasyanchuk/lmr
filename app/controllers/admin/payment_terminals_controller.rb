class Admin::PaymentTerminalsController <  Admin::DashboardController
  defaults :resource_class => PaymentTerminal, :collection_name => 'payment_terminals', :instance_name => 'payment_terminal'
 
  def create
    create! {admin_payment_terminals_path}
  end

end
