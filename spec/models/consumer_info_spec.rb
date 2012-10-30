require 'spec_helper'

RAW_USER_INFO = {
  'consumerCode' => '1',
  'streetCode' => '2',
  'houseCode' => '3',
  'houseNumber' => '4',
  'flatNumber' => '5',
  'flatLetter' => 'a',
  'serviceProvider' => []
}

describe ConsumerInfo do
  
  before :each do
    @user_info = ConsumerInfo.new RAW_USER_INFO
  end
  
  {
    'consumer code' => 'consumerCode',
    'street code' => 'streetCode',
    'house code' => 'houseCode',
    'house number' => 'houseNumber',
    'flat number' => 'flatNumber',
    'flat letter' =>'flatLetter'
  }.each do |attribute_name, reader_name|
    it "stores #{attribute_name}" do
      @user_info.send(reader_name.underscore).should eq(RAW_USER_INFO[reader_name])
    end
  end

  it 'loads raw user info from rest service' do
    new_user_info = mock :user_info
    ConsumerInfo.should_receive(:new).with(:raw_user_info).and_return(new_user_info)
    ReportLoader.should_receive(:load_consumer_info).with(:some_id).and_return(:raw_user_info)


    ConsumerInfo.load(:some_id).should eq(new_user_info)
  end


  it 'provides service providers codes' do
    @user_info.instance_variable_set(:@service_providers, [
      mock(:service_provider, :service_provider_code => 1),
      mock(:service_provider, :service_provider_code => 2),
      mock(:service_provider, :service_provider_code => 3),
      mock(:service_provider, :service_provider_code => 2),
    ])
    codes = @user_info.service_providers_codes
    codes.should include(1,2,3)
    codes.size.should eq(3)

  end
end
