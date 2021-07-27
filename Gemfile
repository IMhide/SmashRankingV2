source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'devise'
gem 'activeadmin'

group :development, :test do
  gem 'brakeman'
  gem 'bundle-audit'
  gem 'factory_bot_rails'
  gem 'figaro'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubycritic', require: false
  gem 'simplecov'
  gem 'standard'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'

  gem 'database_cleaner'
  gem 'rspec-rails'
end
