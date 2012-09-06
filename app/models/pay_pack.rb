class PayPack

  def initialize raw_services
    @payments = raw_services.map do |raw_service|
      ServicePayment.new raw_service
    end
  end

  def payments
    @payments
  end

end
