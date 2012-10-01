class ConsumerInfo

  attr_reader :consumer_code, :street_code, :house_code, :house_number, :flat_number, :flat_letter, :service_providers

  ServiceProvider = Struct.new :provider_code, :provider_name, :service_code, :code, :name, :service_provider_code 
  
  def initialize opts
    @consumer_code = opts['consumerCode']
    @street_code = opts['streetCode']
    @house_code = opts['houseCode']
    @house_number = opts['houseNumber']
    @flat_number = opts['flatNumber']
    @flat_letter = opts['flatLetter']
    fill_service_providers opts['serviceProvider']
  end

  def self.load id
    new ReportLoader.load_consumer_info(id)
  end

  def fill_service_providers raw = []
    @service_providers = raw.map {|raw_service_provider| build_service_provider raw_service_provider }
  end

  def build_service_provider raw
    ServiceProvider.new raw['providerCode'], raw['providerName'], raw['serviceCode'], raw['code'], raw['name'], raw['serviceProviderCode']
  end

end
