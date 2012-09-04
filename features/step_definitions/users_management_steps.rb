#encoding: utf-8
Then /^I should see list of users$/ do
  page.should have_content("Users") 
  page.should have_selector("td:contains('User Admin')") 
end
