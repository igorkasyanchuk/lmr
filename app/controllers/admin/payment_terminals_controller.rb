class Admin::PaymentTerminalsController <  Admin::DashboardController
  defaults :resource_class => PaymentTerminal, :collection_name => 'payment_terminals', :instance_name => 'payment_terminal'

  def index
    @type = params[:payment_terminal][:type] if params[:payment_terminal]
    @payment_terminals =  if @type.present?
        PaymentTerminal.where(type: @type).order(:department)
      elsif params[:q]
        PaymentTerminal.where("address like :q or name like :q or district like :q", :q => "%" + params[:q] + "%")
      else
        PaymentTerminal.order(:type, :name)
      end.page(params[:page]).per(10)
  end
 
  def create
    create! {admin_payment_terminals_url}
  end

  def update
    # update! {admin_payment_terminals_path(payment_terminal: { type: @payment_terminal.type })}
    update! { session.delete(:return_to) }
  end

  def edit
    @payment_terminal = PaymentTerminal.find(params[:id])
    session[:return_to] ||= request.referer
  end

end
