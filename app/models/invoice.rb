class Invoice

  attr_reader :consumer_info, :total, :services, :raw_period_start, :raw_period_end, :error

  Total = Struct.new :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo
  Service = Struct.new :name, :borg, :invoice, :correction, :pilga, :subsidy, :pay, :saldo, :service_code, :sub_services

  def initialize params
    @total = populate_total params['total']
    @services = populate_services params['services']
    @raw_period_start = params['dateBeginPeriod']
    @raw_period_end = params['dateEndPeriod']

    @error = params[:error]
  end

  def self.load id, period
    new ReportLoader.load_invoice(id, period)
  end
  
  def all_services
    (@services + @services.map {|s| s.sub_services}).flatten
  end

  def populate_total raw
    raw ||= {}
Total.new raw['borg'], raw['invoice'], raw['correction'], raw['pilga'], raw['subsidy'], raw['pay'], raw['saldo']
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
  
    #raise raw.inspect
    
    raw.flatten.compact.map do |ss| 
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
