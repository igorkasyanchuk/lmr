require 'spec_helper'

describe PaymentDetails do

  describe '.build_payments' do
    # it 'builds Payment objects from raw' do
    #   PaymentDetails::Payment.should_receive(:new).exactly(3).times
    #   PaymentDetails.build_payments({'payment' => [1, 2, 3]})
    # end

    # it 'stores payments' do
    #   PaymentDetails::Payment.stub(:new).exactly(3).times.and_return(1, 2, 3)
    #   PaymentDetails.build_payments({'payment' => [1, 2, 3]})
    #   PaymentDetails.payments.should eq([1, 2, 3])
    # end
  end

  describe '.collect_payments_to_checks' do
    before :each do      
      @payments_mocks = [
        mock(:payment, :code => '1', :date => 'Today', :sum => 1,
              :bank => mock(:bank, :code => 1, :name => 'bank1'),
              :service_provider => mock(:service_provider, :code => 100, :name => 'provider1'),
              :service => mock(:service, :code => 1, :name => 'service1')),
        mock(:payment, :code => '2', :date => 'Yesterday', :sum => 3,
              :bank => mock(:bank, :code => 2, :name => 'bank2'),
              :service_provider => mock(:service_provider, :code => 200, :name => 'provider2'),
              :service => mock(:service, :code => 3, :name => 'service3')),
        mock(:payment, :code => '1', :date => 'Today', :sum => 2,
              :bank => mock(:bank, :code => 1, :name => 'bank1'),
              :service_provider => mock(:service_provider, :code => 300, :name => 'provider3'),
              :service => mock(:service, :code => 2, :name => 'service2'))
      ]
      @filter_mock = mock(:filter, :service_provider_code => nil, :check_bank_code => nil)
      @services_mock = [
        mock(:service, :service_code => 1, :service_provider_code => 100 ),
        mock(:service, :service_code => 2, :service_provider_code => 200 ),
        mock(:service, :service_code => 3, :service_provider_code => 300),
        mock(:service, :service_code => 4, :service_provider_code => 100)
      ]
      PaymentDetails.instance_variable_set(:@payments, @payments_mocks)
      PaymentDetails.instance_variable_set(:@filter, @filter_mock)
      PaymentDetails.instance_variable_set(:@services, @services_mock)
      PaymentDetails.collect_payments_to_checks
      @checks = PaymentDetails.checks
    end
    it 'collects builds checks total sum from payments' do
      @checks.first.sum.should eq(3)
      @checks.last.sum.should eq(3)
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

    it 'populate banks from checks for input select' do
      PaymentDetails.populate_banks
      PaymentDetails.check_banks.size.should eq(2)
    end

    it 'populate service providers from checks for input select' do
      PaymentDetails.services.size.should eq(4)
      PaymentDetails.check_service_providers.size.should eq(3)
    end

    it 'filter checks by service provider code' do      
      PaymentDetails.services.size.should eq(4)
      @filter_mock_1 = mock(:filter, :service_provider_code => 100, :check_bank_code => nil)
      PaymentDetails.instance_variable_set(:@filter, @filter_mock_1)
      PaymentDetails.services.size.should eq(2)
    end

    it 'filter checks by bank code' do
      PaymentDetails.checks.size.should eq(2)
      @filter_mock_2 = mock(:filter, :service_provider_code => nil, :check_bank_code => 1)
      PaymentDetails.instance_variable_set(:@filter, @filter_mock_2)
      PaymentDetails.checks.size.should eq(1)
    end

    it 'collect service total from checks' do
      @service_total_mock = [ mock(:service_total, :code => 1, :sum => 1),
                              mock(:service_total, :code => 2, :sum => 2),
                              mock(:service_total, :code => 3, :sum => 3),
                              mock(:service_total, :code => 4, :sum => 4) ]
      PaymentDetails.instance_variable_set(:@service_total, @service_total_mock)
      PaymentDetails.service_total.count eq(3)
    end


  end


  describe PaymentDetails::Payment do
    before :each do
      @payment = PaymentDetails::Payment.new 'datePayment' => 'today', 'sum' => '88.88', 'code' => '1234567'
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

  describe PaymentDetails::Check do
    before :each do
      @payments_mocks = [
        mock(:payment, :code => '1', :date => 'Today', :bank => 'bank1', :sum => 1,
              :service => mock(:service, :code => 1, :name => 'service1')),
        mock(:payment, :code => '1', :date => 'Today', :bank => 'bank1', :sum => 2,
              :service => mock(:service, :code => 2, :name => 'service2'))
      ]
      @check = PaymentDetails::Check.new @payments_mocks
    end


    it "#calculate_total by payment sum, stores check date and bank" do
      PaymentDetails::Check.calculate_total(@payments_mocks).should eq(@check.sum)
      @check.date.should eq('Today')
      @check.bank.should eq('bank1')
    end


  end

end