class Invoice

  attr_reader :consumer_info, :total, :services, :raw_period_start, :raw_period_end

  Total = Struct.new :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo
  Service = Struct.new :name, :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo, :service_code, :sub_services

  def initialize params
    @consumer_info = ConsumerInfo.new params['consumer']
    raw_total = params['total']
    @total = Total.new raw_total['borg'], raw_total['invoice'], raw_total['correction'], raw_total['pilga'], raw_total['subsidy'], raw_total['pay'], raw_total['saldo']
    @services = populate_services params['services']
    @raw_period_start = params['dateBeginPeriod']
    @raw_period_end = params['dateEndPeriod']

  end

  def self.load id, period
    new ReportLoader.load_invoice(id, period)
  end

  def populate_services raw
     (raw || []).map do |ms|
      Service.new(
        ms['name'],
        ms['borg'],
        ms['invoice'],
        ms['correction'],
        ms['pilga'],
        ms['subsidy'],
        ms['pay'],
        ms['saldo'],
        ms['serviceCode'],
        populate_sub_services(ms['subService'])
      )
    end
  end

  def populate_sub_services *raw
  
    puts raw.inspect
    
    raw.flatten.map do |ss| 
      Service.new(
        ss['name'],
        ss['borg'],
        ss['invoice'],
        ss['correction'],
        ss['pilga'],
        ss['subsidy'],
        ss['pay'],
        ss['saldo'],
        ss['serviceCode']
      )
    end
  end

end
