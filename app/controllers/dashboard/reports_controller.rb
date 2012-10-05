class Dashboard::ReportsController < Dashboard::DashboardController

  before_filter :set_date

  def info
    @invoice = Invoice.load '4110000106052', @date..@date
  end

  def payments
    @services = Payment.load '4110000106052', (Date.today.beginning_of_month)...Date.today.end_of_month
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
