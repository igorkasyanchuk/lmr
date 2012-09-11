class Invoice

  attr_reader :consumer_info, :total

  Total = Struct.new :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo

  def initialize params
    @consumer_info = ConsumerInfo.new params['consumer']
    raw_total = params['total']
    @total = Total.new raw_total['borg'], raw_total['invoice'], raw_total['correction'], raw_total['pilga'], raw_total['subsidy'], raw_total['pay'], raw_total['saldo']
  end

  def self.load id
    new ReportLoader.load_invoice(id)
  end

end
