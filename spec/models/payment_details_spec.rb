# require 'spec_helper'
# describe PaymentDetails do
#   describe "#populate_payments" do
#     it 'collect payments in check' do
#       ReportLoader.should_receive(:get).
#                   with('https://195.5.31.162:9443/portalrest/lmrrestservice',
#                     :query => {:action => 'payment_by_consumer', :identifier => '4110000106052', :date_begin_period => '2012-10-01', :date_end_period => '2012-10-31'}).
#                   and_return(PAYMENT_BY_CONSUMER)
#     end
#   end
# end