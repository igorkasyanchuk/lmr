require 'spec_helper'
describe PaymentDetails do
  before :each do
    @id = '4110000106052'
    @period = Date.new(2012,10,1)..Date.new(2012,10,31)
    ReportLoader.stub(:load_payments).and_return(PAYMENT_BY_CONSUMER)
    @raw = ReportLoader.load_payments(@id, @period).merge(:consumer_id => @id)
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
  describe "#get_and_populate_checks" do
    it 'get payments and populates in checks' do      
      pd_get = PaymentDetails.get(@id, @period)
      @pd.populate_checks
      @pd.populate_service_total
      @pd.checks.should eq(pd_get.checks)
      @pd.service_total.should eq(pd_get.service_total)
    end
  end
end