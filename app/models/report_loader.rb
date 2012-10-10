class ReportLoader
  include HTTParty
  pem File.read(File.join(Rails.root, 'portal.pem'))

  #SORCE_URL = 'https://10.5.1.37:8443/portalrest/lmrrestservice'
  SOURCE_URL = 'https://195.5.31.162:9443/portalrest/lmrrestservice'

  def self.load identifier
    resp = get('https://10.5.1.37:8443/portalrest/lmrrestservice', :query => {:action => 'bill_search', :identifier => identifier})
    PayPack.new resp['ResponseDebt']['debtPayPack']
  end


  def self.load_consumer_info id = 4070000646163
    request_data('user_info', request_params(id))['consumer'] || {}
  end

  def self.load_invoice_details id = '4070000646163', service_code, period  
    request_data('detail_invoice', request_params(id, :period => period, :service_code => service_code))['invoiceDecode'] || {}
  end

  def self.load_invoice id = '4070000646163', period
    request_data('invoice_by_consumer', request_params(id, :period => period))['invoice'] || {}
  end

  def self.load_payments id = '4070000646163', period
    request_data('payment_by_consumer', request_params(id, :period => period))['paymentDetails'] || {}
    
  end

  private
  def self.request_data action, query
    get SOURCE_URL, :query => query.merge(:action => action)
  end

  def self.request_params id, params = {}
    result = { :identifier => id }
    #raise period.end.inspect
    unless params[:period].nil?
      result.merge!(
        :date_begin_period => params[:period].begin.strftime('%Y-%m-%d'),
        :date_end_period => params[:period].end.strftime('%Y-%m-%d')
      )
    end

    result.merge!(:service_code => params[:service_code]) unless params[:service_code].nil?
    #raise params.inspect
    #raise result.inspect 
    result
  end

end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
