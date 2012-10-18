class InvoiceDetails

  attr_reader :service_name, :service_code, :expenses

  def self.load consumer_id, period
   @period = period
   loaded = ReportLoader.load_invoice_details(consumer_id, period)

   @invoice_details = [loaded['decodeService']].flatten.compact.map do |raw|
     new raw
   end
   @error = loaded[:error]
   self
  end

  def self.period
    @period
  end

  def self.error
    @error
  end

  def self.[] service_code
    @invoice_details.find {|d| d.service_code == service_code }
  end

  def self.services
    @invoice_details
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
