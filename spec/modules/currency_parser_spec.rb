require 'currency_parser'
require 'spec_helper'

describe String do
  it "should parse proper currency from string" do
    "0.45".to_uah.should eq(0.45)
    "0.00000".to_uah.should eq(0.00)
    "0".to_uah.should eq(0.00)
    "".to_uah.should eq(0.00)
    "7.48".to_uah.should eq(7.48)
    "654564564564564.64".to_uah.should eq(654564564564564.64)
  end
end