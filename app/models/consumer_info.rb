class ConsumerInfo

  attr_reader :consumer_code, :pib, :street_code, :street_name, :house_code, :house_number, :house_letter, :flat_number, :people_count, :calc_area, :heat_area, :service_providers, :error
  ServiceProvider = Struct.new :service_provider_code, :service_provider_name, :service_code, :service_name
  
  def initialize opts
    @consumer_code = opts['consumerCode']
    @pib = opts['PIB']
    if opts['address']
      @street_code = opts['address']['streetCode']
      @street_name = opts['address']['streetName']
      @house_number = opts['address']['houseNumber']
      @house_letter = opts['address']['houseLetter']
      @flat_number = opts['address']['flatNumber']
    end
    @house_code = opts['houseCode']
    @people_count = opts['peopleCount']
    @calc_area = opts['calcArea']
    @heat_area = opts['heatArea']

    fill_service_providers opts['serviceProvider']
    @error = opts[:error]
  end

  def self.load id
    new ReportLoader.load_consumer_info(id)
  end

  def fill_service_providers raw
    @service_providers = (raw || []).map {|raw_service_provider| build_service_provider raw_service_provider }
  end

  def build_service_provider raw
    ServiceProvider.new raw['serviceProviderCode'], raw['serviceProviderName'], raw['serviceCode'], raw['serviceName']
  end

  def service_provider_by_service_code service_code
    @service_providers.detect {|sp| sp.service_code == service_code.to_s }
  end

  def service_providers_codes
    @service_providers.map { |sp| sp.service_provider_code }.uniq
  end

  def self.[] id
    @consumers ||= {} 
    @consumers[id] ||= load id
  end

end
