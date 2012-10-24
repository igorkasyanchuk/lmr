# encoding: utf-8
class Counter

  attr_reader :counters
  
  Counter = Struct.new :code, :state_number, :type_code, :type_name, :end_state

  def initialize params
    @counters = populate_counters params['counters']
  end

  def self.load id
    @last_counters = ReportLoader.load_counters(id).merge(:consumer_id => id)
    new @last_counters
  end

  def populate_counters raw
    raw ||= []
    raw.map do |c|
      Counter.new( 
        c['code'], 
        c['stateNumber'],
        c['counterTypeCode'],
        c['counterTypeName'],
        c['endState']
      )
    end
  end

  def self.set_counter opts
    data = opts[:amount].present? :amount : :end_state
    now_number = opts[data]
    if Counter.validation_errors(opts).empty?
      ReportLoader.set_counter(opts[:counter_code], now_number)
    else
      {:errors => Counter.validation_errors(opts)}
    end
  end

  def self.validation_errors opts
    data = opts[:amount].present? :amount : :end_state
    now_number = opts[data]
    max = Counter.find_by_code(opts[:counter_type_code]).send(data)
    previous_number = Counter.get_previous_counter(opts[:counter_code]).send(data)
    Counter.check_counter(now_number, previous_number, max)
  end

  def self.get_previous_counter code
    @counters.select{|c| c.code == code}
  end

  def self.check_counter now, last, max
    errors = []
    if now_number <= 0
      errors << 'не може бути менше нуля'
    elsif now < last
      errors << 'не може бути менше попереднього показника'
    elsif now > max
      errors << 'більше максимально допустимого значення'
    end
    errors
  end

end