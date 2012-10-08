class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :set_date

  def info
    @invoice = Invoice.load '4070000646163', @date.beginning_of_month..@date.end_of_month
  end

  def payments
    @services = Payment.load '4070000646163', (@date.beginning_of_month)..@date.end_of_month
    @consumer_info = @services.consumer_info
  end

  private
  def set_date
    @date = if params[:date].present?
      Date.new params[:date][:year].to_i, params[:date][:month].to_i
    else
      Date.today
    end

  end

end
