Given /^I sign in as moderator$/ do
  steps %{
    When I visit login page
    And I fill login with "moderator"
    And I fill password with "user_pass"
    And I click sign in
  }
end

Given /^I sign in as admin$/ do
  steps %{
    When I visit login page
    And I fill login with "administrator"
    And I fill password with "user_pass"
    And I click sign in
  }
end

Given /^I sign in as regular user$/ do
  steps %{
    When I visit login page
    And I fill login with "regular_user"
    And I fill password with "user_pass"
    And I click sign in
  }
end

Given /^I click sign in$/ do
  find('form[action="/login"] input[type=submit]').click
end

Given /^I fill login with "(\w+)"$/ do |login|
  fill_in 'user_login', :with => login
end

Given /^I fill password with "(\w+)"$/ do |password|
  fill_in 'user_password', :with => password
end
