class ConsumerInfo

  attr_reader :consumer_code, :street_code, :house_code, :house_number, :house_letter, :flat_number, :flat_letter, :service_providers, :error
  ServiceProvider = Struct.new :service_provider_code, :service_provider_name, :service_code, :service_name, :error
  
  def initialize opts
    @consumer_code = opts['consumerCode']
    @street_code = opts['streetCode']
    @house_code = opts['houseCode']
    @house_number = opts['houseNumber']
    @house_letter = opts['houseLetter']
    @flat_number = opts['flatNumber']
    @flat_letter = opts['flatLetter']
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

  def self.[] id
    @consumers ||= {} 
    @consumers[id] ||= load id
  end

end
