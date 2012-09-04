#encoding: utf-8
Then /^I should see list of page parts$/ do
  page.should have_content("Page Parts") 
  page.should have_content("NEW_CONTACTS_PAGE") 
end
