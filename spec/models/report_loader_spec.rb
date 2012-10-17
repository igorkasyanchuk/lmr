require 'spec_helper'



describe ReportLoader do
  describe "#load" do
    it 'loads data by id' do
      PayPack.stub :new
      ReportLoader.should_receive(:get).with('https://10.5.1.37:8443/portalrest/lmrrestservice', :query => {:action => 'bill_search', :identifier => 'identifier'}).and_return(REST_RESPONSE)
      ReportLoader.load 'identifier'
    end
  end
  it "builds PayPack objects from received data" do
    pay_pack = mock :pay_pack

    ReportLoader.stub(:get).and_return(REST_RESPONSE)
    PayPack.should_receive(:new).with(REST_RESPONSE['ResponseDebt']['debtPayPack']).and_return([pay_pack])
    
    
    ReportLoader.load('id').should eq([pay_pack])
  end

  describe '#request_data' do
    it "returns error description when exception happened" do
      ReportLoader.stub(:get).and_raise(StandardError)
      ReportLoader.request_data(:action, {})[:any_key].should eq({:error => 'connection failed'})
    end
  end

end
