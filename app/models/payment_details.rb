# encoding: utf-8
class PaymentDetails
  require 'currency_parser'

  attr_reader :checks, :service_total
  
  Check = Struct.new :date_payment, :bank, :services, :total_sum
  Bank = Struct.new :code, :name, :mfo, :rr

  def initialize params
    @checks = populate_checks params['payment']
    @service_total = populate_service_total params['total']['totalService']
  end

  def self.load id, period
    new ReportLoader.load_payments(id, period).merge(:consumer_id => id)
  end

  def populate_checks raw
    checks = {}
    raw = [raw || []].flatten
    raw.each do |raw_payment|
      code = raw_payment['code']
      if checks[code]
        add_services_to_check raw_payment, checks[code]
      else
        checks[code] = new_check raw_payment
      end
    end
    checks
  end

  def new_check raw
    Check.new( 
      raw['datePayment'], 
      populate_check_bank(raw['bank']),
      Hash[raw['service']['serviceCode'] => raw['sum'].to_uah],
      raw['sum'].to_uah
    )
  end

  def add_services_to_check raw, check
    check.services[raw['service']['serviceCode']] = raw['sum'].to_uah
    check.total_sum = check.total_sum + raw['sum'].to_uah
  end

  def populate_check_bank raw
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

end