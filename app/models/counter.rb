# encoding: utf-8
class Counter

  attr_accessor :code, :state_number, :type_code, :type_name, :end_state
  
  CounterHistory = Struct.new :counter_id, :counter_state_number, :year, :month, :begin_state, :end_state

  def initialize raw
    @code = raw['code']
    @state_number = raw['stateNumber']
    @type_code = raw['counterTypeCode']
    @type_name = raw['counterTypeName']
    @end_state = raw['endState']
  end

  def self.get id
    @user_counters = ReportLoader.load_counters(id).map{|raw| Counter.new(raw)}
  end

  def history year = Date.today.year
    Counter.load_counter_history_by_year(self.code, year).reverse
  end

  def self.load_counter_history_by_year code, year = Date.today.year
    [ReportLoader.load_counter_history_by_year(code, year)].flatten.map{|raw| populate_counter_history(raw)}
  end

  def self.populate_counter_history raw
    CounterHistory.new( 
      raw['counterID'],
      raw['counterStateNumber'],
      raw['year'], 
      raw['month'],        
      raw['beginState'],
      raw['endState']
    )
  end

  def last_history year = Date.today.year
    history(year).reject{|h| h.month == Date.today.month}.try(:first)
  end

  def self.set_counter code, state
    errors = Counter.validation_errors(code, state)
    errors.empty? ? ReportLoader.set_counter(code, state.to_i) : {:errors => errors}
  end

  def self.validation_errors code, state
    last_counter = last_history_of_counter(code)
    previous_counter_number = last_counter.present? ? last_counter.end_state : state
    check_counter_numbers(state, previous_counter_number)
  end

  def self.last_history_of_counter code
    counter = @user_counters.select{|c| c.code == code}.first
    if counter
      counter.last_history ? counter.last_history : counter.last_history(Date.today.year - 1)
    end
  end

  def self.check_counter_numbers now, previous
    errors = []

    if not_number?(now)
      errors << 'Показник повинен бути цілим числом'
    elsif now.to_i < 0
      errors << 'Показник не може бути менше нуля'
    elsif now.to_i == 0
      errors << 'Показник не може дорівнювати нулю'
    elsif now.to_i < previous.to_i
      errors << 'Введений показник не може бути менше попереднього показника'
    # elsif now > max
    #   errors << 'більше максимально допустимого значення'
    end
    errors
  end

  private

  def self.not_number?(str)
    str.match(/\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/) == nil ? true : false
  end

end