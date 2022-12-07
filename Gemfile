source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'activeadmin'
gem 'view_component'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'enumerize'
gem 'graphql-client'
gem 'jbuilder', '~> 2.7'
gem 'light_admin', github: 'CapSens/light_admin'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'rails-i18n'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'trueskill', github: 'saulabs/trueskill', require: 'saulabs/trueskill'
gem 'rack-cors'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'bootstrap', '~> 5.2.2'

group :development, :test do
  gem 'brakeman'
  gem 'bundle-audit'
  gem 'factory_bot_rails'
  gem 'figaro'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubycritic', require: false
  gem 'simplecov'
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

gem 'importmap-rails', '~> 1.1'

# Use Redis for Action Cable
gem 'redis', '~> 4.0'
