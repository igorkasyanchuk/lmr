class Invoice

  attr_reader :consumer_info, :total, :main_services

  Total = Struct.new :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo
  Service = Struct.new :name, :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo, :subservices

  def initialize params
    @consumer_info = ConsumerInfo.new params['consumer']
    raw_total = params['total']
    @total = Total.new raw_total['borg'], raw_total['invoice'], raw_total['correction'], raw_total['pilga'], raw_total['subsidy'], raw_total['pay'], raw_total['saldo']
    @main_services = populate_main_services params['mainService']

  end

  def self.load id
    new ReportLoader.load_invoice(id)
  end

  def populate_main_services raw
    raw.map do |ms|
      Service.new ms['name'], ms['borg'], ms['invoice'], ms['correction'], ms['pilga'], ms['subsidy'], ms['pay'], ms['saldo'], populate_sub_services(ms['subService'])
    end
  end

  def populate_sub_services raw
    raw.map do |ss| 
      Service.new ss['name'], ss['borg'], ss['invoice'], ss['correction'], ss['pilga'], ss['subsidy'], ss['pay'], ss['saldo']
    end
  end

end
