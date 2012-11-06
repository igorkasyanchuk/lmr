source 'https://rubygems.org'

gem 'rails', '3.2.8'

# gem 'dbf'
gem 'mysql2'
gem 'devise'
gem 'forem', :git => "git://github.com/radar/forem.git"
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'slim'
gem 'slim-rails'

gem 'inherited_resources', '1.3.1'
gem "simple_form", "~> 2.0.2"
gem 'galetahub-simple_captcha', :require => "simple_captcha" 
gem 'settingslogic'
gem 'awesome_nested_fields'
gem 'ckeditor', :path => 'vendor/gems/ckeditor'

gem 'carrierwave'
gem 'mini_magick'
gem 'truncate_html'
gem 'gmaps4rails'

gem 'httparty'
gem 'prawn'
gem 'mailman', require: false

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'execjs'
gem 'therubyracer'

gem 'coffee-rails', '~> 3.2.1'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails" , '2.1.3'
end

group :development do
  gem 'quiet_assets'
  gem 'thin'
  gem 'debugger'
  gem 'wirb'
  gem "letter_opener"
end

group :test do
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem "capybara"
  gem "poltergeist"
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork-rails'
  gem 'simplecov', :require => false
  if RUBY_PLATFORM.downcase.include?('linux')
    gem 'rb-inotify', '~> 0.8.8'
  elsif RUBY_PLATFORM.downcase.include?('darwin')
    gem 'rb-fsevent'
  end
  gem 'fuubar'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'
gem "nested_form"
gem "airbrake"
gem "spreadsheet"
gem "dalli"