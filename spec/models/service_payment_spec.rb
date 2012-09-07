require 'spec_helper'

describe ServicePayment do
  before :each do
    @service_payment = ServicePayment.new DEBT_PAY_PACK[0]
  end
  it "stores payment address" do
    @service_payment.address.should eq(DEBT_PAY_PACK[0]['address'])
  end
  it "stores bill identifier" do
    @service_payment.bill_identifier.should eq(DEBT_PAY_PACK[0]['bill_identifier'])
  end
  it "stores bill period" do
    @service_payment.bill_period.should eq(DEBT_PAY_PACK[0]['bill_period'])
  end
  it "stores fio" do
    @service_payment.fio.should eq(DEBT_PAY_PACK[0]['fio'])
  end

  it "stores payer ls" do
    @service_payment.payer_ls.should eq(DEBT_PAY_PACK[0]['service']['payer']['ls'])
  end

  it "stores service name" do
    @service_payment.service_name.should eq(DEBT_PAY_PACK[0]['service']['ks']['service'])
  end
  it "stores service code" do
    @service_payment.service_code.should eq(DEBT_PAY_PACK[0]['service']['ks']['service_code'])
  end
  it "stores company code" do
    @service_payment.company_code.should eq(DEBT_PAY_PACK[0]['service']['ks']['company_code'])
  end

  {
    'provider_account_no' => 'provider accoun number',
    'prepayment' => 'prepayment',
    'amount_to_pay' => 'amount_to_pay',
    'charge' => 'charge',
    'debt' => 'debt',
    'last_paying' => 'last paying',
  }.each_pair do |attribute, human_name|
    it "stores #{human_name}" do
      @service_payment.debt.send(attribute).should eq(DEBT_PAY_PACK[0]['service']['debt'][attribute])
    end
  end

end
