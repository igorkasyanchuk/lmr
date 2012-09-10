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

Then /^I should see link to manage forum sections$/ do
  page.should have_selector("a[href='/community/admin/forums']")
end

Then /^I should see link to manage categories$/ do
  page.should have_selector("a[href='/community/admin/categories']")
end

Then /^I should see link to manage forum users$/ do
  page.should have_selector("a[href='/community/admin/users_list']")
end

Then /^I should not see links to manage users$/ do
  page.should_not have_selector("a[href='/admin/users']")
end

Then /^I should not see links to manage pages$/ do
  page.should_not have_selector("a[href='/admin/pages']")
end

Then /^I should not see links to manage news$/ do
  page.should_not have_selector("a[href='/admin/posts']")
end

Then /^I should not see links to manage page parts$/ do
  page.should_not have_selector("a[href='/admin/page_parts']")
end

Then /^I should not see links to view feedback$/ do
  page.should_not have_selector("a[href='/admin/contacts']")
end

Then /^I should not see links to track site activities$/ do
  page.should_not have_selector("a[href='/admin/activities']")
end

Then /^I should not see link to manage forum sections$/ do
  page.should_not have_selector("a[href='/community/admin/forums']")
end

Then /^I should not see link to manage categories$/ do
  page.should_not have_selector("a[href='/community/admin/categories']")
end

Then /^I should not see link to manage forum users$/ do
  page.should_not have_selector("a[href='/community/admin/users_list']")
end

