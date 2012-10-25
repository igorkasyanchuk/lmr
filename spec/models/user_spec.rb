require 'spec_helper'

describe User do

  describe '#service_providers' do
    it 'provides consumers service providrers' do
      user = User.new
      user.stub(:consumer_info).and_return(mock(:consumer_info, :service_providers_codes => [1,2,3]))
      ServiceProvider.should_receive(:where).with(:code => [1,2,3])

      user.service_providers
    end
  end

end
