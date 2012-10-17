class PaymentReport

  def initialize params
    @filter = params[:filter]
    @services = params[:consumer_services]
    @checks = params[:checks]
  end

  def consumer_services
    if @filter && @filter.service_provider_code.present?
      @services.select{|sp| sp.service_provider_code == @filter.service_provider_code}
    else
      @services
    end
  end

  def checks
    @checks.checks.select &select_check_proc
  end

  def service_total
    pcodes = []
    checks.each { |k,v| pcodes << v.services.keys }
    @checks.service_total.select{|k, v| pcodes.flatten.include?(k)}
  end

  def select_check_proc
    spcodes = consumer_services.map(&:service_code)
    if @filter && @filter.check_bank_code.present?
      lambda { |k,v| ( ( spcodes & v.services.keys ).any? && v.bank.code == @filter.check_bank_code ) }
    else
      lambda { |k,v| ( spcodes & v.services.keys ).any? }
    end
  end

end