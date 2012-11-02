# encoding: utf-8
class PaymentDetails
  require 'currency_parser'
  attr_reader :error

  def self.load id, filter, services
    raw = ReportLoader.load_payments(id, filter.period)
    @error = raw[:error]
    @services = services    
    @filter = filter
    unless @error.present?
      PaymentDetails.build_payments raw
      PaymentDetails.collect_payments_to_checks
      PaymentDetails.populate_banks
      PaymentDetails.build_service_total raw
    end
  end

  def self.checks
    service_codes = PaymentDetails.services.map(&:service_code)
    @checks ||= []
    @checks = @checks.select{ |check| ( service_codes & check.payments.map{|p| p.service.code}.flatten ).any? }
    if @filter.check_bank_code.present?
      @checks = @checks.select{ |check| check.bank.code == @filter.check_bank_code }
    else
      @checks
    end
  end

  def self.service_total
    checks_service_codes = PaymentDetails.checks.map{ |check| check.payments.map{|p| p.service.code} }.flatten
    @service_total ||= []
    @service_total = @service_total.select{ |k, v| checks_service_codes.include?(k) }
  end

  def self.services    
    if @filter.service_provider_code.present?
      @services = @services.select{ |sp| sp.service_provider_code == @filter.service_provider_code }
    else
      @services
    end
  end

  def self.error
    @error
  end

  def self.check_service_providers
    @services.uniq_by { |sp| sp.service_provider_code }
  end

  def self.check_banks
    @check_banks ||= []
    @check_banks.uniq_by { |b| b.code }
  end

  def self.build_payments raw
    @payments = (raw['payment'] || []).map do |raw_payment|
      Payment.build_payment(raw_payment)
    end
  end

  def self.populate_banks
    @check_banks = []
    @checks.each { |c| @check_banks << c.bank }
  end

  def self.build_service_total raw
    @service_total = {}
    raw = raw['total']['totalService'] if raw['total']    
    if raw
      raw = [raw].flatten
      raw.each do |total_service|
        @service_total[total_service['code']] = total_service['sum']
      end
    end
  end

  def self.collect_payments_to_checks
    @checks = @payments.group_by{ |payment| payment.code }.
      map { |payment_code, payments| Check.new payments}
  end

  class Payment

    attr_accessor :date, :sum, :code, :service, :service_provider, :bank

    Service = Struct.new :name, :code
    ServiceProvider = Struct.new :name, :code
    Bank = Struct.new :code, :name, :mfo, :rr

    def initialize raw
      @date = raw['datePayment']
      @code = raw['code']
      @sum = raw['sum'].to_uah
    end

    def build_service raw
      @service = Service.new raw['serviceName'], raw['serviceCode']
    end

    def build_service_provider raw
      @service_provider = ServiceProvider.new raw['name'], raw['code']
    end

    def build_bank raw
      @bank = Bank.new raw['code'], raw['name'], raw['MFO'], raw['RR']
    end

    def self.build_payment raw
      payment = Payment.new(raw)
      payment.build_service raw['service']
      payment.build_service_provider raw['serviceProvider']
      payment.build_bank raw['bank']
      payment
    end

  end

  class Check

    attr_reader :date, :bank, :payments, :sum    
    
    def initialize payments
      @sum = Check.calculate_total payments
      @bank = payments.first.bank
      @date = payments.first.date
      @payments = payments
    end

    def self.calculate_total payments
      payments.inject(0){|tot, p| tot + p.sum }
    end

  end

end
