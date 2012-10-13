class Filter
  attr_accessor :period, :service_provider_code, :payment_bank_code

  class Period
    attr_reader :begin, :end

    def initialize params
      build_start params[:begin]
      build_end params[:end]
    end

  private
    def build_start params
      @begin = if params.present?
        Date.new(params[:year].to_i, params[:month].to_i)
      else
        Date.today
      end.beginning_of_month
    end

    def build_end params
      @end = if params.present?
         Date.new(params[:year].to_i, params[:month].to_i)
      else
        @begin
      end.end_of_month
    end

  end
  
  def initialize params
    @period = Period.new({begin: params[:period_begin], end: params[:period_end]})
    @service_provider_code = params[:service_provider_code]
    @payment_bank_code = params[:payment_bank_code]
  end

  def period_begin
    @period.begin
  end

  def period_end
    @period.end
  end

end