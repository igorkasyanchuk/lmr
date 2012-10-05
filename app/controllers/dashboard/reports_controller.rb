class Dashboard::ReportsController < Dashboard::DashboardController

  def info
    set_date
    @invoice = Invoice.load 'id', @date..@date
  end

  def payments
    set_date
    @services = Payment.load 'id', (Date.today.beginning_of_month)...Date.today.end_of_month
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
