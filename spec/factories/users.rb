FactoryGirl.define do
  factory :user do
    name 'User'
    surname 'Regular'
    identifier '12345'
    email 'test_user@example.com'
    password 'user_pass'
    password_confirmation 'user_pass'
    blocked false

    after :build do |user|
      user.class.skip_callback(:create, :after)
      user.confirm!
      user.role = FactoryGirl.create :user_role
    end

    factory :admin_user do
      surname 'Admin'
      identifier 'administrator'

      after :build do |user|
        user.class.skip_callback(:create, :after)
        user.confirm!
        user.role = FactoryGirl.create :admin_role
      end
    end

    factory :moderator_user do
      surname 'Moderator'
      identifier 'moderator'
      after :build do |user|
        user.class.skip_callback(:create, :after)
        user.confirm!
        user.role = FactoryGirl.create :moderator_role
      end
    end

  end
end
