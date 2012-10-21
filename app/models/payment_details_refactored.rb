# encoding: utf-8
class PaymentDetailsRefactored
require 'currency_parser'

  class Payment

    attr_accessor :date, :sum, :code, :service, :service_provider, :bank

    Service = Struct.new :name, :code
    ServiceProvider = Struct.new :name, :code
    Bank = Struct.new :name, :code, :mfo, :rr

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
      @bank = Bank.new raw['name'], raw['code'], raw['MFO'], raw['RR']
    end

  end

  Check = Struct.new :code, :date, :payments

  def self.build_payments raw
    @payments = raw['payment'].map do |raw_payment|
      Payment.new raw_payment
    end
  end

  def self.payments
    @payments
  end

  def self.checks
    @checks
  end

  def self.collect_payments_to_checks
    #@checks = @payments.map(&:code).uniq.map{ |payment_code| Check.new payment_code}
    @checks = @payments.group_by{ |payment| [payment.code, payment.date] }.
      map { |payment_code_and_date, payments| Check.new *payment_code_and_date, payments}
  end

end
