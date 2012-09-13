#encoding: utf-8
Then /^I should see list of news$/ do
  page.should have_content("Адміністрування новин") 
  page.should have_selector("td:contains('Event 1')") 
  page.should have_selector("td:contains('Event 2')") 
end

When /^I fill in post title with "(.*?)"$/ do |title|
  fill_in 'Заголовок', :with => title
end

When /^I fill in post description with "(.*?)"$/ do |description|
  fill_in 'Опис', :with => description
end

When /^I fill in post content with "(.*?)"$/ do |content|
  fill_in 'Опис', :with => content
end

When /^I check post published checkbox$/ do
  check 'У публікації?'
end

When /^I fill in post roots url with "(.*?)"$/ do |url|
  fill_in 'Посилання на джерела', :with => url
end

When /^I fill in post author with "(.*?)"$/ do |author|
  fill_in 'Автор', :with => author
end

When /^I submit post page form$/ do
  click_button 'Зберегти новину'
end

Then /^I should see "(.*?)" in a list$/ do |title|
  page.should have_content(title) 
end

Then /^I go to "(.*?)" post edit form$/ do |title|
  within("tr:contains('#{title}')") do
    click_link 'Редагувати'
  end
end

When /^I delete post "(.*?)"$/ do |title|
  within("tr:contains('#{title}')") do
    click_link 'Видалити'
  end
end

Then /^I should not see "(.*?)" in posts list$/ do |title|
  page.should_not have_content(title)
end