Given /^moderator user$/ do
  FactoryGirl.create :moderator_user
end

Given /^admin user$/ do
  FactoryGirl.create :admin_user
end

Given /^regular user$/ do
  FactoryGirl.create :user
end

Given /^static page "(.*?)"$/ do |identifier|
  FactoryGirl.create :page, :identifier => identifier, :title => identifier
end

Given /^news entry "(.*?)"$/ do |title|
  FactoryGirl.create :post,  :title => title
end

Given /^feedback with message "(.*?)"$/ do |message|
  FactoryGirl.create :contact,  :message => message
end

Given /^page part "(.*?)"$/ do |identifier|
  FactoryGirl.create :page_part,  :identifier => identifier
end

Given /^user activity "(.*?)"$/ do |activity|
  FactoryGirl.create :user_activity,  :activity => activity
end
