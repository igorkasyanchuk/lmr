FactoryGirl.define do
  factory :conversation do
    service_provider_id 111
    token '1234567890'
    body 'text'
    subject 'subject'
    after :create do |c|      
      c.messages << FactoryGirl.create(:message)
    end
  end
end