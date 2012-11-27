require 'spec_helper'

RAW_USER_INFO = {
  'consumerCode' => '1',
  'PIB' => '2',
  'address' => {
    'cityName' => '3',
    'streetCode' => '4',
    'streetName' => '5',  
    'houseNumber' => '6',
    'houseLetter' => '7',
    'flatNumber' => '8'
  },

  'houseCode' => '9',
  'peopleCount' => '10',
  'calcArea' => '11',
  'heatArea' => '12',
  'serviceProvider' => []
}

describe ConsumerInfo do
  
  before :each do
    @user_info = ConsumerInfo.new RAW_USER_INFO
  end
  
  {
    'consumer code' => 'consumerCode',
    'PIB' => 'PIB',
    'house code' => 'houseCode',
    'people count' => 'peopleCount',
    'calc area' => 'calcArea',
    'heat area' =>'heatArea'
  }.each do |attribute_name, reader_name|
    it "stores #{attribute_name}" do
      @user_info.send(reader_name.underscore).should eq(RAW_USER_INFO[reader_name])
    end
  end

  {
    # 'city name' => 'cityName',
    'street code' => 'streetCode',
    'street name' => 'streetName',  
    'house number' => 'houseNumber',
    'house Letter' => 'houseLetter',
    'flat number' => 'flatNumber'
  }.each do |attribute_name, reader_name|
    it "stores #{attribute_name}" do
      @user_info.send(reader_name.underscore).should eq(RAW_USER_INFO['address'][reader_name])
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
