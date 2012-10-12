# encoding: utf-8
class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :init_filter

  def info
    @invoice = Invoice.load '4070000646163', @filter.period#@date.beginning_of_month..@date.end_of_month
    @details = InvoiceDetails.load '4110000106052', @filter.period
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context)
        send_data pdf.render, filename: "invoice_4070000646163.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def payments
    @current_month_payments = PaymentDetails.load '4110000106052', current_period
    @selected_period_payments = PaymentDetails.load '4110000106052', @filter.period#selected_period
    @payments_banks = @selected_period_payments.payments.map(&:bank)
    @all_service_providers = ConsumerInfo['4110000106052'].service_providers
    @consumer_info = @current_month_payments.consumer_info
    @payment_report = PaymentReport.new consumer_services: @all_service_providers, payments: @current_month_payments
    @payment_report_filtered = PaymentReport.new filter: @filter, consumer_services: @all_service_providers, payments: @selected_period_payments


  end

  def invoice_details
    @invoice_details = InvoiceDetails.load '4110000106052', @filter.period
    report = InvoiceDetailsPdf.new(@invoice_details, view_context)
    send_data report.render, file_name: "invoice_details_#{@filter.period_begin.strftime('%Y-%m')}.pdf",
                             type: 'application/pdf',
                             disposition: 'inline'

  end

  private

  def init_filter
    @filter = Filter.new period_begin: params[:period_begin], period_end: params[:period_end], service_provider_code: params[:service_provider_code], payment_bank_code: params[:payment_bank_code]
  end

  def current_period
    today = Date.today
    today.beginning_of_month..today.end_of_month
  end

end
