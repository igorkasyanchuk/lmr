=begin
Then /^I should see link to reports page$/ do
  page.should have_selector("a[href='/admin/posts']")
end

Then /^I should see link to payments page$/ do
  page.should have_selector("a[href='/admin/posts']")
end
=end

Then /^I should see link to profile page$/ do
  page.should have_selector("a[href='/dashboard/profile/edit']")
end

Then /^I should not see link to profile page$/ do
  page.should_not have_selector("a[href='/dashboard/profile/edit']")
end
