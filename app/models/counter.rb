# encoding: utf-8
class Counter

  attr_reader :counters
  
  Counter = Struct.new :code, :state_number, :type_code, :type_name, :end_state

  def initialize params
    @counters = populate_counters params['counters']
  end

  def self.load id
    new ReportLoader.load_counters(id).merge(:consumer_id => id)
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

end