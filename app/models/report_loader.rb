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
    request_data('user_info', request_params(id))['consumer'] || {:error => 'no data'}
  end

  def self.load_invoice_details id = '4070000646163', period  
    request_data('detail_invoice', request_params(id, :period => period))['invoiceDecode'] || {}
  end

  def self.load_invoice id = '4070000646163', period
    request_data('invoice_by_consumer', request_params(id, :period => period))['invoice'] || {}
  end

  def self.load_payments id = '4070000646163', period
    request_data('payment_by_consumer', request_params(id, :period => period))['paymentDetails'] || {}    
  end

  def self.load_last_counters id = '4110000106052'
    request_data('get_counters', request_params(id))['consumerCounters'] || {}
  end

  def self.load_counters_by_year id = '4110000106052', year
    request_data('get_counters_by_month', request_params(id, :year => year))['consumerCounters'] || {}
  end

  def self.set_counter code = '41112100001060520000176117', end_state
    request_data('set_counter_factor', :counter_code => code, :end_state => end_state)['consumerCounters']['isCompleted'] || {}
  end

  private
  def self.request_data action, query
    r = get SOURCE_URL, :query => query.merge(:action => action)
    r.code == 404 ? (raise Exception) : r
  rescue Exception
    Hash.new({:error => 'connection failed'})
  end

  def self.request_params id, params = {}
    result = { :identifier => id }
    unless params[:period].nil?
      result.merge!(
        :date_begin_period => params[:period].begin.strftime('%Y-%m-%d'),
        :date_end_period => params[:period].end.strftime('%Y-%m-%d')
      )
    end
    result.merge!(:service_code => params[:service_code]) unless params[:service_code].nil?
    result.merge!(:year => params[:year]) unless params[:year].nil?
    result
  end

end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE