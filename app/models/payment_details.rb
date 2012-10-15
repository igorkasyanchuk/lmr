# encoding: utf-8
class PaymentDetails

  attr_reader :payments, :service_total
  
  Payment = Struct.new :date_payment, :bank, :services, :total_sum
  Bank = Struct.new :code, :name, :mfo, :rr

  def initialize params
    @payments = populate_payments params['payment']
    @service_total = populate_service_total params['total']['totalService']
    @consumer_id = params[:consumer_id]
  end

  def self.load id, period
    new ReportLoader.load_payments(id, period).merge(:consumer_id => id)
  end

  def populate_payments raw
    p = {}
    raw = [raw || []].flatten
    raw.each do |ms|
      code = ms['code']
      sum = ms['sum']
      if p[code]
        p[code].services[ms['service']['serviceCode']] = sum
        p[code].total_sum = p[code].total_sum + sum.to_f
      else
        p[code] = Payment.new( 
          ms['datePayment'], 
          populate_payment_bank(ms['bank']), 
          Hash[ms['service']['serviceCode'] => sum],
          sum.to_f
          )
      end
    end
    p
  end

  def populate_payment_bank raw
    Bank.new(raw['code'], raw['name'], raw['MFO'], raw['RR'])
  end

  def populate_service_total raw
    t = {}
    raw = [raw || []].flatten
    raw.each do |st|
      t[st['code']] = st['sum']
    end
    t
  end

  def consumer_info
    ConsumerInfo[@consumer_id]
  end

end