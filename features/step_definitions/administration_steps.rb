Given /^admin user$/ do
  FactoryGirl.create :admin_user
end

Given /^I sign in as admin$/ do
  visit '/login'
  print page.html
  fill_in 'user_login', :with => 'administrator'
  fill_in 'user_password', :with => 'user_pass'
  find('input[type=submit]').click
end

When /^I go to admin section$/ do
  visit '/admin'
end

Then /^I should see links to manage users$/ do
  page.should have_selector("a[href='/admin/users']")
end

Then /^I should see links to manage pages$/ do
  page.should have_selector("a[href='/admin/pages']")
end

Then /^I should see links to manage news$/ do
  page.should have_selector("a[href='/admin/posts']")
end

Then /^I should see links to manage page parts$/ do
  page.should have_selector("a[href='/admin/page_parts']")
end

Then /^I should see links to view feedback$/ do
  page.should have_selector("a[href='/admin/contacts']")
end

Then /^I should see links to track site activities$/ do
  page.should have_selector("a[href='/admin/activities']")
end
