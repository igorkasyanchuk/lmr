# encoding: utf-8
class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :init_filter
  before_filter :user_info, :except => [:service_providers]

  def invoice
    @invoice = Invoice.load current_user.identifier, @filter.period#@date.beginning_of_month..@date.end_of_month
    @details = InvoiceDetails.load current_user.identifier, @filter.period
    @benefit_list = Benefit.load current_user.identifier, @filter.period
    PaymentDetails.load(current_user.identifier, @filter, @user_info.service_providers)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context,
                             @filter.period.begin, @user_info,
                             Counter.get(@user_info.consumer_code).sort_by!{|x| [x.type_name, x.state_number]} )
        send_data pdf.render, filename: "invoice_#{@user_info.consumer_code}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def payments
    PaymentDetails.load(current_user.identifier, @filter, @user_info.service_providers)
  end

  def counter
    code = params[:code]
    @year = params[:year].present? ? params[:year] : Date.today.year
    counters = Counter.get @user_info.consumer_code
    @counter = counters.select{|c| c.code == code}.first
    respond_to do |format|
      format.js
      format.pdf do
        pdf = CounterPdf.new(@counter, @year)
        send_data pdf.render, filename: "counter_#{@user_info.consumer_code}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def counters
    @counters = Counter.get(@user_info.consumer_code).sort_by!{|x| [x.type_name, x.state_number]}
    if request.xhr?
      result = Counter.set_counters(params)
      if result.has_key?(:results)
        @results = result[:results].compact
        respond_to :js
      elsif result.has_key?(:errors)
        @errors = result[:errors]
        render 'counter_error', :formats => [:js]
      end
    end
  end
  
  def service_providers
    @service_providers = current_user.service_providers
  end

  def invoice_details
    @invoice_details = InvoiceDetails.load current_user.identifier, @filter.period
    report = InvoiceDetailsPdf.new(@invoice_details, view_context, @user_info)
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