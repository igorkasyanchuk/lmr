require 'spec_helper'

describe Counter do
  describe 'read counters' do

    it 'should build collection of counters from raw' do
      ReportLoader.should_receive(:load_counters_by_year).with(:consumer_identifier, 2012).and_return([:raw_counter1, :raw_counter2, :raw_counter3])
      Counter.stub(:new).exactly(3).times.and_return(:counter1, :counter2, :counter3)
      Counter.get(:consumer_identifier, 2012).should eq([:counter1, :counter2, :counter3])
    end

    it 'should return counter' do
      ReportLoader.should_receive(:load_counters_by_year).with(:consumer_identifier, 2012).and_return([:raw_counter1, :raw_counter2, :raw_counter3])
      Counter.get(:consumer_identifier, 2012).first.should be_instance_of(Counter)
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
end