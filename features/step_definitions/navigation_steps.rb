When /^I visit login page$/ do
  visit '/login'
end

When /^I go to admin section$/ do
  visit '/admin'
end

When /^I go to forum admin section$/ do
  visit '/community/admin'
end

When /^I go to news section$/ do
  visit '/news'
end


When /^I go to personal page$/ do
  visit '/dashboard'
end

When /^I go to static pages management page$/ do
  visit '/admin/pages'
end

When /^I go to users management page$/ do
  visit '/admin/users'
end

When /^I go to static page parts$/ do
  visit '/admin/page_parts'
end

When /^I go to feedabacks page$/ do
  visit '/admin/contacts'
end

When /^I go to activities list$/ do
  visit '/admin/activities'
end

When /^I go to news management page$/ do
  visit '/admin/posts'
end

Then /^I open edit "(.*?)" form$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^I visit new page form$/ do
  visit '/admin/pages/new'
end

Given /^I visit new post form$/ do
  visit '/admin/posts/new'
end

