class Admin::PaymentTerminalsController <  Admin::DashboardController
  defaults :resource_class => PaymentTerminal, :collection_name => 'payment_terminals', :instance_name => 'payment_terminal'

  def index
    @type = params[:payment_terminal][:type] if params[:payment_terminal]
    @payment_terminals =  if @type && @type != ''
      PaymentTerminal.where(type: @type)
    else
      PaymentTerminal.order(:type)
    end.page(params[:page]).per(10)
  end
 
  def create
    create! {admin_payment_terminals_url}
  end

  def update
    update! {admin_payment_terminals_url}
  end

end
