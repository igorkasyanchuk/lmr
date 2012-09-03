FactoryGirl.define do
  factory :role do
    factory :admin_role do
      name 'admin'
    end
    factory :moderator_role do
      name 'content_manager'
    end
    factory :user_role do
      name 'user'
    end
  end
end
