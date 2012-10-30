# encoding: utf-8
class Counter

  attr_accessor :date, :code, :state_number, :type_code, :type_name, :end_state

  # attr_reader :counters
  
  # Counter = Struct.new :code, :state_number, :type_code, :type_name, :end_state

  def initialize raw
    @date = raw['date']
    @code = raw['code']
    @state_number = raw['stateNumber']
    @type_code = raw['counterTypeCode']
    @type_name = raw['counterTypeName']
    @end_state = raw['endState']
  end

  # def self.load id, year=Date.today.year
  #   @counters = ReportLoader.load_counters_by_month(id).merge(:consumer_id => id)
  #   new @counters
  # end

  def self.get id, year
    ReportLoader.load_counters_by_year(id, year).map{|raw| Counter.new(raw)}
  end

  # def self.get_months_from year
  #   end_month= Date.today.year == year ? Date.today.month : 12
  #   months = (1..end_month).to_a
  #   months.map!{|m| Date.new(year, m, 1)}
  # end

  # def populate_counters raw
  #   raw ||= []
  #   raw.map do |c|
  #     Counter.new( 
  #       c['code'], 
  #       c['stateNumber'],
  #       c['counterTypeCode'],
  #       c['counterTypeName'],
  #       c['endState']
  #     )
  #   end
  # end

  # def self.set_counter opts
  #   data = opts[:counter_state]
  #   now_number = opts[data.to_sym]
  #   if Counter.validation_errors(opts).empty?
  #     ReportLoader.set_counter(opts[:counter_code], now_number)
  #   else
  #     {:errors => Counter.validation_errors(opts)}
  #   end
  # end

  # def self.validation_errors opts
  #   data = opts[:counter_state]
  #   now_number = opts[data.to_sym]
  #   max = Counter.find_by_code(opts[:counter_type_code]).send(data)
  #   previous_number = Counter.get_previous_counter(opts[:counter_code]).send(data)
  #   Counter.check_counter(now_number, previous_number, max)
  # end

  # def self.get_previous_counter code
  #   @counters.select{|c| c.code == code}
  # end

  # def self.check_counter now, last, max
  #   errors = []
  #   if now_number <= 0
  #     errors << 'не може бути менше нуля'
  #   elsif now < last
  #     errors << 'не може бути менше попереднього показника'
  #   elsif now > max
  #     errors << 'більше максимально допустимого значення'
  #   end
  #   errors
  # end

end