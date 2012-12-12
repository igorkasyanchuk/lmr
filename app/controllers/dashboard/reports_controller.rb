# encoding: utf-8
class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :init_filter
  before_filter :user_info, :except => [:invoice_details, :service_providers]

  def invoice
    @invoice = Invoice.load current_user.identifier, @filter.period#@date.beginning_of_month..@date.end_of_month
    @details = InvoiceDetails.load current_user.identifier, @filter.period
    @benefit_list = Benefit.load current_user.identifier, @filter.period
    PaymentDetails.load(current_user.identifier, @filter, @user_info.service_providers)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context, @filter.period.begin)
        send_data pdf.render, filename: "invoice_4070000646163.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def payments
    PaymentDetails.load(current_user.identifier, @filter, @user_info.service_providers)
  end

  def counters
    year = params[:year] || Date.today.year
    @counters = Counter.get @user_info.consumer_code
  end

  def counter
    code = params[:code]
    @year = params[:year].to_i
    counters = Counter.get @user_info.consumer_code
    @counter = counters.select{|c| c.code == code}.first
    render 'counter', :formats => [:js]
  end

  def set_counter
    result = Counter.set_counter(params[:counter_code], params[:end_state])
    if result == 'true'
      @counter = counters.select{|c| c.code == params[:counter_code]}.first
      @year = Date.today.year
      render 'counter', :formats => [:js]
    elsif result == 'false'
      render :js => "alert('Показник НЕ додано!');"
    else
      render :js => "alert('#{result[:errors].first}');"
    end
  end
  
  def service_providers
    @service_providers = current_user.service_providers
  end

  def invoice_details
    @invoice_details = InvoiceDetails.load current_user.identifier, @filter.period
    report = InvoiceDetailsPdf.new(@invoice_details, view_context)
    send_data report.render, file_name: "invoice_details_#{@filter.period_begin.strftime('%Y-%m')}.pdf",
                             type: 'application/pdf',
                             disposition: 'inline'

  end

  private

    def init_filter
      @filter = Filter.new period_begin: params[:period_begin], period_end: params[:period_end], service_provider_code: params[:service_provider_code], check_bank_code: params[:check_bank_code]
    end

    def current_period
      today = Date.today
      today.beginning_of_month..today.end_of_month
    end

    def user_info
      @user_info = current_user.consumer_info
    end

end
