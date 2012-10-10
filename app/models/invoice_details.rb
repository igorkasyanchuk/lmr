class InvoiceDetails

  attr_reader :service_name, :service_code, :expenses

  def self.load consumer_id, service_code, period
      
     [ReportLoader.load_invoice_details(consumer_id, service_code, period)].flatten.map do |raw|
       new raw
     end
  end

  Expense = Struct.new :sum, :name, :code

  def initialize params
    #raise params.inspect
    #raise params['decodeService']['decode'].inspect
    @service_name = params['decodeService']['decodeServiceName']
    @service_code = params['decodeService']['decodeServiceCode']
    fill_expenses params['decodeService']['decode']
  end

  def fill_expenses raw
    @expenses = (raw || []).map do |re|
      Expense.new re['decodeSum'], re['decodeName'], re['decodeCode']
    end
  end

end
