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
      email 'test_admin@example.com'

      after :build do |user|
        user.class.skip_callback(:create, :after)
        user.confirm!
        user.role = FactoryGirl.create :admin_role
      end
    end

    factory :moderator_user do
      surname 'Moderator'
      identifier 'moderator'
      email 'test_moderator@example.com'
      after :build do |user|
        user.class.skip_callback(:create, :after)
        user.confirm!
        user.role = FactoryGirl.create :moderator_role
      end
    end

    factory :spam_user do
      identifier '111111'
      email 'spam_user@example.com'
      forem_state 'spam'
      after :build do |user|
        user.class.skip_callback(:create, :after)
        user.confirm!
      end
    end

  end
end
