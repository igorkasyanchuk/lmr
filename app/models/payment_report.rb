class PaymentReport

  def initialize params
    @filter = params[:filter]
    @services = params[:consumer_services]
    @payments = params[:payments]
  end

  def consumer_services
    if @filter && @filter.service_provider_code.present?
      @services.select{|sp| sp.service_provider_code == @filter.service_provider_code}
    else
      @services
    end
  end

  def payments
    @payments.services.select &select_payment_proc
  end

  def select_payment_proc
    spcodes = consumer_services.map(&:service_code)
    if @filter && @filter.payment_bank_name.present?
      lambda {|p| spcodes.include?(p.service_code) && p.payment_bank.name == @filter.payment_bank_name}
    else
      lambda {|p| spcodes.include?(p.service_code)}
    end
  end

end