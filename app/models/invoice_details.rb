class InvoiceDetails

  attr_reader :service_name, :service_code, :expenses

  def self.load consumer_id, service_code, period
   @invoice_details = [ReportLoader.load_invoice_details(consumer_id, service_code, period)['decodeService']].flatten.compact.map do |raw|
     new raw
   end
   self
  end

  def self.[] service_code
    @invoice_details.find {|d| d.service_code == service_code }
  end

  Expense = Struct.new :sum, :name, :code

  def initialize params
    @service_name = params['decodeServiceName']
    @service_code = params['decodeServiceCode']
    fill_expenses params['decode']
  end

  def fill_expenses raw
    @expenses = (raw || []).map do |re|
      Expense.new re['decodeSum'], re['decodeName'], re['decodeCode']
    end
  end

  

end
