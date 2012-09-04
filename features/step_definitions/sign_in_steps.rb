Given /^I sign in as moderator$/ do
  visit '/login'
  fill_in 'user_login', :with => 'moderator'
  fill_in 'user_password', :with => 'user_pass'
  find('input[type=submit]').click
end

Given /^I sign in as admin$/ do
  visit '/login'
  fill_in 'user_login', :with => 'administrator'
  fill_in 'user_password', :with => 'user_pass'
  find('input[type=submit]').click
end

Given /^I sign in as regular user$/ do
  visit '/login'
  fill_in 'user_login', :with => 'regular_user'
  fill_in 'user_password', :with => 'user_pass'
  find('input[type=submit]').click
end

