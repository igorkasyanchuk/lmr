#encoding: utf-8
When /^I fill in title with "(.*?)"$/ do |title|
  fill_in 'Заголовок', :with => title
end

When /^I fill in content with "(.*?)"$/ do |content|
  fill_in 'Зміст', :with => content
end

When /^I fill in url title with "(.*?)"$/ do |url_title|
  fill_in 'page_identifier', :with => url_title
end

When /^I submit page form$/ do
  click_button 'Зберегти сторінку' # express the regexp above with the code you wish you had
end

Then /^I should see title "(.*?)"$/ do |title|
  page.should have_selector("input[value='#{title}']")
end

Then /^I should see content "(.*?)"$/ do |content|
  page.should have_content(content)
end

Given /^I go to "(.*?)" edit form$/ do |title|
  within("tr:contains('#{title}')") do
    click_link 'Редагувати'
  end
end

When /^I delete "(.*?)"$/ do |title|
  within("tr:contains('#{title}')") do
    click_link 'Видалити'
  end
end

Then /^I should not see "(.*?)" in pages list$/ do |title|
  page.should_not have_content(title)
end
