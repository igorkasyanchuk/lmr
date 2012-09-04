#encoding: utf-8
Then /^I should see list of activities$/ do
  page.should have_content("Дії на сайті") 
  page.should have_content("some activity") 
end
