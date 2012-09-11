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
  }
}

describe Invoice do
  before :each do
    @invoice = Invoice.new RAW_INVOICE_INFO
  end
  
  it 'loads raw invoice info fro rest service' do
    new_invoice = mock :invoice
    ReportLoader.should_receive(:load_invoice).with(:some_id).and_return(:raw_invoice_info)
    Invoice.should_receive(:new).with(:raw_invoice_info).and_return(new_invoice)


    Invoice.load(:some_id).should eq(new_invoice)
  end

  it 'stores consumer info' do
    raw_invoice = {'consumer' => :raw_consumer_info, 'total' => {}}
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
end
