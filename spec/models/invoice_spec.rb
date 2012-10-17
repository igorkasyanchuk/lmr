#encoding: utf-8
require 'spec_helper'

RAW_INVOICE_INFO = {
  'consumer' => {
    'consumerCode' => '',
    'streetCode' => '',
    'houseCode' => '',
    'houseNumber' => '',
    'houseLetter' => '',
    'flatNumber' => '',
  },
  'total' => {
    'borg' => '1',
    'invoice' => '2',
    'correction' => '3',
    'pilga' => '4',
    'subsidy' => '5',
    'pay' => '6',
    'salo' => '7',
  },
  'services' => [
  {
  "subService"=>[
    {
      "name"=>"Гаряча вода",
      "borg"=>"22",
      "invoice"=>"178",
      "correction"=>"15",
      "pilga"=>"43",
      "subsidy"=>"78",
      "pay"=>"",
      "saldo"=>"44"
    },
    {
        "name"=>"Холодна вода",
        "borg"=>"44", 
        "invoice"=>"78",
        "correction"=>"45",
        "pilga"=>"123", 
        "subsidy"=>"148",
        "pay"=>"", 
        "saldo"=>"33"
    }
  ],
    "name"=>"Вода", 
    "borg"=>"10",
    "invoice"=>"10",
    "correction"=>"100",
    "pilga"=>"25",
    "subsidy"=>"64",
    "pay"=>"",
    "saldo"=>"78"
  }]
}

describe Invoice do
  before :each do
      ConsumerInfo.stub :new
    @invoice = Invoice.new RAW_INVOICE_INFO
  end
  
  it 'loads raw invoice info fro rest service' do
    new_invoice = mock :invoice
    ReportLoader.should_receive(:load_invoice).with(:some_id, :some_period).and_return(:raw_invoice_info)
    Invoice.should_receive(:new).with(:raw_invoice_info).and_return(new_invoice)


    Invoice.load(:some_id, :some_period).should eq(new_invoice)
  end

  it 'stores consumer info' do
    raw_invoice = {'consumer' => :raw_consumer_info, 'total' => {}, 'mainService' => []}
    ConsumerInfo.should_receive(:new).with(:raw_consumer_info).and_return(:consumer_info)
    
    Invoice.new(raw_invoice).consumer_info.should eq(:consumer_info)
  end
  
  describe '#total' do
    %w{borg invoice correction pilga subsidy pay saldo}.each do |attribute_name|
      it "stores total #{attribute_name}" do
        @invoice.total.send(attribute_name).should eq RAW_INVOICE_INFO['total'][attribute_name]
      end
    end
  end

  it 'stores main services collection' do

    #service = Invoice::Service.new RAW_INVOICE_INFO['mainService']['name']
    Invoice::Service.stub!(:new).and_return(:service)# RAW_INVOICE_INFO['mainService']['name']

    invoice = Invoice.new RAW_INVOICE_INFO
    invoice.services.should include(:service)
  end

  describe "#populate_services" do
    before :each do
      @services = @invoice.populate_services RAW_INVOICE_INFO['services']
    end
    %w{name borg invoice correction pilga subsidy pay saldo}.each do |attribute_name|
      it "stores #{attribute_name}" do
        @services.first.send(attribute_name).should eq(RAW_INVOICE_INFO['services'][0][attribute_name])
      end
    end
  end

  describe "#populate_sub_services" do
    before :each do
      @sub_services = @invoice.populate_sub_services RAW_INVOICE_INFO['services'][0]['subService']
    end
    %w{name borg invoice correction pilga subsidy pay saldo}.each do |attribute_name|
      it "stores #{attribute_name}" do
        @sub_services.first.send(attribute_name).should eq(RAW_INVOICE_INFO['services'][0]['subService'][0][attribute_name])
      end
    end
  end

end
