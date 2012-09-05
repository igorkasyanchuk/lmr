#encoding: utf-8
Then /^I should see list of feedbacks$/ do
  page.should have_content("Зворотній зв'язок") 
  page.should have_content("I love this site") 
end
