class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :init_filter

  def info
    @invoice = Invoice.load '4070000646163', @filter.period#@date.beginning_of_month..@date.end_of_month
  end

  def payments
    @current_month_payments = Payment.load '4070000646163', current_period
    @selected_period_payments = Payment.load '4070000646163', @filter.period#selected_period
    @service_providers = ConsumerInfo['4070000646163'].service_providers
    @consumer_info = @current_month_payments.consumer_info
  end

  private
  def init_filter
    @filter = Filter.new period_begin: params[:period_begin], period_end: params[:period_end], service_provider_id: params[:service_provider_id]
  end

  def current_period
    today = Date.today
    today.beginning_of_month..today.end_of_month
  end

end
