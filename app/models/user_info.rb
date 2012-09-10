class UserInfo

  attr_reader :consumer_code, :street_code, :house_code, :house_number, :flat_number, :flat_letter
  
  def initialize opts
    @consumer_code = opts['consumerCode']
    @street_code = opts['streetCode']
    @house_code = opts['houseCode']
    @house_number = opts['houseNumber']
    @flat_number = opts['flatNumber']
    @flat_letter = opts['flatLetter']
  end

  def self.load id
    new ReportLoader.load_user_info(id)
  end

end
