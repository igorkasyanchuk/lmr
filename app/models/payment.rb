class Payment

  attr_reader :payments

  Service = Struct.new :service_code, :payment_date, :payd_sum, :payment_bank
  PaymentBank = Struct.new :name, :mfo, :rr, :provider_code

  def initialize params
    @payments = populate_services params['paymentDetails']['services']
    @consumer_id = params[:consumer_id]
  end

  def self.load id, period
    new ReportLoader.load_payments(id, period).merge(:consumer_id => id)
  end

  def populate_services raw
    raw.map do |ms|
      Service.new(
        ms['serviceCode'],
        ms['dateServicePayment'],
        ms['paydSum'],  
        populate_payment_bank(ms['paymentBank'])      
      )
    end
  end

  def populate_payment_bank raw
    PaymentBank.new(raw['name'], raw['MFO'], raw['RR'], raw['serviceProviderCode'])
  end

  def consumer_info
    ConsumerInfo[@consumer_id]
  end

end