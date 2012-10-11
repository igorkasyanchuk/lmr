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
    @payments.payments.select &select_payment_proc
  end

  def service_total
    pcodes = payments.map{|p| p.service['serviceCode']}
    @payments.service_total.select{|st| pcodes.include?(st.code)}
  end

  def select_payment_proc
    spcodes = consumer_services.map(&:service_code)
    if @filter && @filter.payment_bank_code.present?
      lambda {|p| spcodes.include?(p.service['serviceCode']) && p.bank.code == @filter.payment_bank_code}
    else
      lambda {|p| spcodes.include?(p.service['serviceCode'])}
    end
  end

end