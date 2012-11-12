# encoding: utf-8
class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :init_filter

  def info
    @invoice = Invoice.load current_user.identifier, @filter.period#@date.beginning_of_month..@date.end_of_month
    @details = InvoiceDetails.load current_user.identifier, @filter.period
    @user_info = current_user.consumer_info
    PaymentDetails.load( current_user.identifier, @filter, @user_info.service_providers)
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
    @user_info = current_user.consumer_info
    PaymentDetails.load(current_user.identifier, @filter, @user_info.service_providers)
  end

  def counters
    @user_info = current_user.consumer_info
    year = params[:year] || Date.today.year
    # @counters_by_month = Counter.load('4110000106052', year)
  end

  def counter
    result = Counter.set_counter(params)
    if result == 'true'
      render 'counter.js'
    else
      # render result[:errors]
      render :nothing => true
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

end
