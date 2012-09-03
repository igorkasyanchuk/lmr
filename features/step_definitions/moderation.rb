Given /^moderator user$/ do
  FactoryGirl.create :moderator_user
end

Given /^I sign in as moderator$/ do
  visit '/login'
  print page.html
  fill_in 'user_login', :with => 'moderator'
  fill_in 'user_password', :with => 'user_pass'
  find('input[type=submit]').click
end

Then /^I should not see links to manage users$/ do
  page.should_not have_selector("a[href='/admin/users']")
end
