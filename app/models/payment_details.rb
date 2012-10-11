# encoding: utf-8
class PaymentDetails

  attr_reader :payments, :service_total

  Payment = Struct.new :date_payment, :service, :service_provider, :bank, :sum
  Bank = Struct.new :code, :name, :mfo, :rr
  ServiceTotal = Struct.new :code, :name, :sum

  def initialize params
    @payments = populate_payments params['payment']
    @service_total = populate_service_total params['total']['totalService']
    @consumer_id = params[:consumer_id]
  end

  def self.load id, period
    new ReportLoader.load_payments(id, period).merge(:consumer_id => id)
  end

  def populate_payments raw
    raw = [raw || []].flatten
    raw.map do |ms|
      Payment.new(
        ms['datePayment'],
        ms['service'],
        ms['serviceProvider'],
        populate_payment_bank(ms['bank']),
        ms['sum']
      )
    end
  end

  def populate_payment_bank raw
    Bank.new(raw['code'], raw['name'], raw['MFO'], raw['RR'])
  end

  def populate_service_total raw
    raw = [raw || []].flatten
    raw.map do |st|
      ServiceTotal.new( st['code'], st['name'], st['sum'] )
    end
  end

  def consumer_info
    ConsumerInfo[@consumer_id]
  end

end