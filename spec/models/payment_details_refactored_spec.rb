require 'spec_helper'

describe PaymentDetailsRefactored do

  describe '.build_payments' do
    it 'builds Payment objects from raw' do
      PaymentDetailsRefactored::Payment.should_receive(:new).exactly(3).times
      PaymentDetailsRefactored.build_payments({'payment' => [1, 2, 3]})
    end

    it 'stores payments' do
      PaymentDetailsRefactored::Payment.stub(:new).exactly(3).times.and_return(1, 2, 3)
      PaymentDetailsRefactored.build_payments({'payment' => [1, 2, 3]})
      PaymentDetailsRefactored.payments.should eq([1, 2, 3])
    end
  end

  describe '.collect_payments_to_checks' do
    before :each do
      @payments_mocks = [
        mock(:payment, :code => '10101', :date => 'Today'), 
        mock(:payment, :code => '12121', :date => 'Yesterday'), 
        mock(:payment, :code => '10101', :date => 'Today')
      ]
      PaymentDetailsRefactored.instance_variable_set(:@payments, @payments_mocks)
      PaymentDetailsRefactored.collect_payments_to_checks
      @checks = PaymentDetailsRefactored.checks
    end
    it 'collects builds uniq checks from payments by payment code' do
      @checks.first.code.should eq('10101')
      @checks.last.code.should eq('12121')
      @checks.size.should eq(2)
    end

    it 'collects payments to checks by payment code' do
      @checks.first.payments.should include(@payments_mocks.first, @payments_mocks.last)
      @checks.first.payments.size.should eq(2)
      @checks.last.payments.should include(@payments_mocks.second)
      @checks.last.payments.size.should eq(1)
    end

    it 'collects payment dates to checks' do
      @checks.first.date.should eq('Today')
      @checks.last.date.should eq('Yesterday')
    end
  end


  describe PaymentDetailsRefactored::Payment do
    before :each do
      @payment = PaymentDetailsRefactored::Payment.new 'datePayment' => 'today', 'sum' => '88.88', 'code' => '1234567'
    end

    it '#build_service populates service data' do
      @payment.build_service('serviceName' => 'Service One', 'serviceCode' => '2')
      @payment.service.name.should eq('Service One')
      @payment.service.code.should eq('2')
    end

    it "#build_service_provider populates service provider data " do
      @payment.build_service_provider('name' => 'ServiceProviderOne', 'code' => '3')
      @payment.service_provider.name.should eq('ServiceProviderOne')
      @payment.service_provider.code.should eq('3')
    end
    it "#build_bank populates bank data" do
      @payment.build_bank('name' => 'BankOne', 'code' => '4', 'MFO' => '12345', 'RR' => '123456')
      @payment.bank.name.should eq('BankOne')
      @payment.bank.code.should eq('4')
      @payment.bank.mfo.should eq('12345')
      @payment.bank.rr.should eq('123456')
    end

    it "stores payment date, sum and payment code" do
      @payment.date.should eq('today')
      @payment.sum.should eq(88.88)
      @payment.code.should eq('1234567')
    end
  end


  

end
