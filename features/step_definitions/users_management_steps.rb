#encoding: utf-8
Then /^I should see list of users$/ do
  page.should have_content("Адміністрування користувачів") 
  page.should have_selector("td:contains('User Admin')") 
end

When /^I fill in email with "(.*?)"$/ do |email|
  fill_in 'E-mail', :with => email
end

When /^I fill in name with "(.*?)"$/ do |name|
  fill_in "Ім'я", :with => name
end

When /^I fill in surname with "(.*?)"$/ do |surname|
  fill_in "Прізвище", :with => surname 
end

When /^I fill in password with "(.*?)"$/ do |password|
  fill_in "Пароль", :with => password 
  fill_in "Підтвердження паролю", :with => password 
end

Then /^I should see "(.*?)" in list$/ do |user|
  page.should have_content(user)
end

Then /^I should not see "(.*?)" in list$/ do |user|
  page.should_not have_content(user)
end

When /^I save user$/ do
  click_button 'Змінити'
end

When /^I create user$/ do
  click_button 'Додати користувача'
end
