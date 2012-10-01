class Payment

  attr_reader :services

  Service = Struct.new :service_code, :payment_date, :payd_sum, :payment_bank
  PaymentBank = Struct.new :name, :mfo, :rr, :provider_code

  def initialize params
    @services = populate_services params['paymentDetails']['services']
  end

  def self.load id
    new ReportLoader.load_payments(id)
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

end