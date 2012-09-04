#encoding: utf-8
Then /^I should see list of news$/ do
  page.should have_content("Адміністрування новин") 
  page.should have_selector("td:contains('Event 1')") 
  page.should have_selector("td:contains('Event 2')") 
end
