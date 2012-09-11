#encoding: utf-8
Then /^I should see only admin notification$/ do
  #page.should have_content('У вас недостатньо прав')
  page.should have_content('Ви повинні бути адміністратором.')
end

