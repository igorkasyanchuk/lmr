class Admin::PaymentTerminalsController <  Admin::DashboardController
  defaults :resource_class => PaymentTerminal, :collection_name => 'payment_terminals', :instance_name => 'payment_terminal'

  def index
    @type = params[:payment_terminal][:type] if params[:payment_terminal]
    @payment_terminals =  if @type.present?
        PaymentTerminal.where(type: @type).order(:department)
      else
        PaymentTerminal.order(:type, :name)
      end.page(params[:page]).per(10)
  end
 
  def create
    create! {admin_payment_terminals_url}
  end

  def update
    update! {admin_payment_terminals_path(payment_terminal: { type: @payment_terminal.type })}
  end

end
