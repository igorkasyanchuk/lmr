class Dashboard::ReportsController < Dashboard::DashboardController

  def info
    @date =if params[:date].present?
      Date.new params[:date][:year].to_i, params[:date][:month].to_i
    else
      Date.today
    end
    @invoice = Invoice.load 'id', @date..@date
  end

end
