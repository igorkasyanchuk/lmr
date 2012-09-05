#encoding: utf-8
Then /^I should see list of static pages$/ do
  #print page.html
  page.should have_content("Адміністрування Сторінок") 
  page.should have_selector("td:contains('help')") 
  page.should have_selector("td:contains('about')") 
end

