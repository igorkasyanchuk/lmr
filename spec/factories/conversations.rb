FactoryGirl.define do
  factory :conversation do
    token '1234567890'
    body 'text'
    subject 'subject'

    after :build do |conversation|
      conversation.service_provider = FactoryGirl.create :service_provider
    end
  end
end