class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :init_filter

  def info
    @invoice = Invoice.load '4070000646163', @filter.period#@date.beginning_of_month..@date.end_of_month
  end

  def payments
    @current_month_payments = Payment.load '4070000646163', @filter.period#current_period
    @selected_period_payments = Payment.load '4070000646163', @filter.period#selected_period
    @consumer_info = @current_month_payments.consumer_info
  end

  private
  def init_filter
    @filter = Filter.new period_begin: params[:period_begin], period_end: params[:period_end]
  end

end
