require 'spec_helper'

describe PayPack do
  it 'create service object for each service entry' do

    ServicePayment.should_receive(:new).exactly(5).times
    PayPack.new [1,2,3,4,5]
  end

  it 'stores service payments' do
    ServicePayment.stub(:new).and_return(1)
    PayPack.new([1,2,3,4,5]).payments.should eq([1,1,1,1,1])
  end

end
