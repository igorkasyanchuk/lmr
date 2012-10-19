require 'spec_helper'
describe PaymentDetails do
  before :each do
    @id = '4110000106052'
    @period = Date.new(2012,10,1)..Date.new(2012,10,31)
    @raw = ReportLoader.stub(:load_payments).and_return(PAYMENT_BY_CONSUMER.merge(:consumer_id => @id))
    @pd = PaymentDetails.new(@id, @period)
  end
  describe "#populate_checks" do
    it 'collect payments in check' do      
      @pd.checks.should eq(nil)
      @pd.populate_checks      
      @pd.checks.count.should eq(@raw['payment'].map{|x| x['code']}.uniq.count)
    end
  end
  describe "#populate_service_total" do
    it 'collect service totals' do
      @pd.service_total.should eq(nil)
      @pd.populate_service_total
      @pd.service_total.count.should eq(@raw['total']['totalService'].count)
    end
  end
  describe "#error" do
    it 'ensure error appear when exception' do
      ReportLoader.stub(:load_payments).and_return({:error => 'connection failed'})
      pd_get = PaymentDetails.get(@id, @period)
      pd_get.error.should eq('connection failed')
    end
  end
end