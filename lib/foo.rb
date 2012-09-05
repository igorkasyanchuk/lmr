require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Foo
  include HTTParty
  pem File.read('/home/deployer/portal3.pem')

  def self.test
    puts Foo.get('https://10.5.1.37:8443/portalrest/lmrrestservice', :query => {:action => 'bill_search', :identifier => '4110000106052'})
  end
end



