Given /^moderator user$/ do
  FactoryGirl.create :moderator_user
end

Given /^admin user$/ do
  FactoryGirl.create :admin_user
end

Given /^regular user$/ do
  FactoryGirl.create :user
end

