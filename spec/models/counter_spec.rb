require 'spec_helper'

describe Counter do
  describe 'read counters' do

    it 'should build collection of counters from raw' do
      ReportLoader.should_receive(:load_counters).with(:consumer_identifier).and_return([:raw_counter1, :raw_counter2, :raw_counter3])
      Counter.stub(:new).exactly(3).times.and_return(:counter1, :counter2, :counter3)
      Counter.get(:consumer_identifier).should eq([:counter1, :counter2, :counter3])
    end

    it 'should return counter' do
      ReportLoader.should_receive(:load_counters).with(:consumer_identifier).and_return([:raw_counter1, :raw_counter2, :raw_counter3])
      Counter.get(:consumer_identifier).first.should be_instance_of(Counter)
    end

    describe "#populate_counter_attributes" do
      raw = {'code' => 'code', 'stateNumber' => 'state_number', 'counterTypeCode' => 'type_code',
                'counterTypeName' => 'type_name', 'endState' => 'end_state'}                
      before :each do        
        @counter = Counter.new(raw)
      end

      raw.each do |k, v|
        it "should check correctly stores counter #{k}" do
          @counter.send(v).should eq(raw[k])
        end
      end

    end    

  end

  describe 'counter history' do
    
    it 'should return counter history by year' do
      ReportLoader.should_receive(:load_counter_history_by_year).with(:counter_code, Date.today.year).and_return([:raw_counter_history1, :raw_counter_nistory2, :raw_counter_history3])
      Counter.stub(:populate_counter_history).exactly(3).times.and_return(:counter_history1, :counter_history2, :counter_history3)
      Counter.load_counter_history_by_year(:counter_code, Date.today.year).should eq([:counter_history1, :counter_history2, :counter_history3])
    end


    it 'should return previous counter' do
      MockHistory = Struct.new :month
      history_mock = [MockHistory.new(Date.today.month), MockHistory.new(Date.today.month - 1), MockHistory.new(Date.today.month - 2)]
      counter = Counter.new({'code' => :counter_code})
      user_counters_mock = [counter, Counter.new({'code' => :counter_code2}), Counter.new({'code' => :counter_code3})]
      Counter.instance_variable_set(:@user_counters, user_counters_mock)
      counter.stub(:history).and_return(history_mock)
      Counter.last_history_of_counter(:counter_code).month.should eq(Date.today.month - 1)
    end

    it 'should return last available state from history of counter' do
      MockHistory = Struct.new :month
      history_mock = [MockHistory.new(Date.today.month - 5), MockHistory.new(Date.today.month - 6), MockHistory.new(Date.today.month - 7)]
      counter = Counter.new({'code' => :counter_code})
      user_counters_mock = [counter, Counter.new({'code' => :counter_code2}), Counter.new({'code' => :counter_code3})]
      Counter.instance_variable_set(:@user_counters, user_counters_mock)
      counter.stub(:history).and_return(history_mock)
      Counter.last_history_of_counter(:counter_code).month.should eq(Date.today.month - 5)
    end

    it 'should return nil when no available previous history or counter' do
      history_mock = []
      counter = Counter.new({'code' => :counter_code})
      user_counters_mock = [counter, Counter.new({'code' => :counter_code2}), Counter.new({'code' => :counter_code3})]
      Counter.instance_variable_set(:@user_counters, user_counters_mock)
      counter.stub(:history).and_return(history_mock)
      Counter.last_history_of_counter(:counter_code).should eq(nil)
      counter2 = Counter.new({'code' => :counter_without_history_code})
      Counter.last_history_of_counter(:counter_without_history_code).should eq(nil)
    end

    # it 'should return previous year counter numbers when no counters in current year' do
    #   MockHistory = Struct.new :month
    #   history_mock_current_year = []
    #   history_mock = [MockHistory.new(Date.today.month - 12)]
    #   counter = Counter.new({'code' => :counter_code})
    #   user_counters_mock = [counter, Counter.new({'code' => :counter_code2}), Counter.new({'code' => :counter_code3})]
    #   Counter.instance_variable_set(:@user_counters, user_counters_mock)
    #   counter.stub(:last_history).and_return(history_mock_current_year)
    #   Counter.last_history_of_counter(:counter_code).month.should eq(nil)
    #   # counter.stub(:last_history).and_return(false)
    # end

    it 'should validate counter errors' do
      Counter.check_counter_numbers(20, 10).should eq([])
      Counter.check_counter_numbers(10, 10).should eq([])
      Counter.check_counter_numbers(10, 20).count.should eq(1)
      Counter.check_counter_numbers(-10, 20).count.should eq(1)
    end



  end

  describe 'set counter' do

    it 'should set counter' do
      ReportLoader.should_receive(:set_counter).with(:counter_code, :end_state).and_return(true)
      Counter.stub_chain(:validation_errors, :empty?).and_return(true)
      Counter.set_counter(:counter_code, :end_state).should eq(true)
    end

    it 'should return error when counter can not be set' do
      Counter.stub(:validation_errors).and_return(['error'])
      Counter.stub_chain(:validation_errors, :empty?).and_return(false)
      Counter.set_counter(:counter_code, :end_state).should eq({:errors => ['error']})
    end

  end

end