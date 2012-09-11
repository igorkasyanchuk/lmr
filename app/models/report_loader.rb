class ReportLoader
  include HTTParty
  pem File.read(File.join(Rails.root, 'portal.pem'))

  def self.load identifier
    resp = get('https://10.5.1.37:8443/portalrest/lmrrestservice', :query => {:action => 'bill_search', :identifier => identifier})
    PayPack.new resp['ResponseDebt']['debtPayPack']
  end


  def self.load_consumer_info id = 4110000106052

    #request_data 'user_info', id
    get('https://dl.dropbox.com/u/3541456/cons.xml')['consumer']
  end

  def self.request_data action, id
    resp = get('https://10.5.1.37:8443/mistocashrest/lmrrestservice', :query => {:action => action, :identifier => id})
  end

  def self.load_invoice id = '4110000106052'
    get('https://dl.dropbox.com/u/3541456/invoice.xml')['invoice']
  end

end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
