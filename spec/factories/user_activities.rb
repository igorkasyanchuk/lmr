# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_activity do
    activity "MyString"
    user_id 1
    params "MyString"
  end
end
