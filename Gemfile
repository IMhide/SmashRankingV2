source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'activeadmin'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'enumerize'
gem 'graphql-client'
gem 'jbuilder', '~> 2.7'
gem 'light_admin', github: 'CapSens/light_admin'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3.1'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'trueskill', github: 'saulabs/trueskill', require: 'saulabs/trueskill'
gem 'rack-cors'
gem 'view_component'

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
  gem 'faker'
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

# Use Redis for Action Cable
gem "redis", "~> 4.0"

gem "tailwindcss-rails", "~> 2.0"
