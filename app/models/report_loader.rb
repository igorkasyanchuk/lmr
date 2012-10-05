class ReportLoader
  include HTTParty
  pem File.read(File.join(Rails.root, 'portal.pem'))

  #SORCE_URL = 'https://10.5.1.37:8443/portalrest/lmrrestservice'
  SOURCE_URL = 'https://195.5.31.162:9443/portalrest/lmrrestservice'

  def self.load identifier
    resp = get('https://10.5.1.37:8443/portalrest/lmrrestservice', :query => {:action => 'bill_search', :identifier => identifier})
    PayPack.new resp['ResponseDebt']['debtPayPack']
  end


  def self.load_consumer_info id = 4110000106052

    request_data('user_info', request_params(id))['consumer'] || {}
    #get('https://dl.dropbox.com/u/3541456/user_info.xml')['consumer']
  end

  def self.load_invoice id = '4110000106052', period
    request_data('invoice_by_consumer', request_params(id, period))['invoice'] || {}
    #get('https://dl.dropbox.com/s/ojle52xxjxma0mk/invoice_finaly.xml?dl=1')['invoice'] || {}
  end

  def self.load_payments id = '4110000106052', period
    request_data('payment_by_consumer', request_params(id, period))['paymentDetails'] || {}
    
    #get('https://dl.dropbox.com/u/3541456/payment_by_consumer.xml')
  end

  private
  def self.request_data action, query
    get SOURCE_URL, :query => query.merge(:action => action)
  end

  def self.request_params id, period = nil
    params = { :identifier => id }
    unless period.nil?
      params.merge!(
        :date_begin_period => period.begin.strftime('%Y-%m-%d'),
        :date_end_period => period.end.strftime('%Y-%m-%d')
      )
    end
    params
  end

end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
