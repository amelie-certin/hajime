# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Rails
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.3'

# Database
gem 'sqlite3'
# gem 'bcrypt', '~> 3.1.7'

# Assets
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby

# Attachments
gem 'paperclip', '~> 5.1'

# JSON
gem 'jbuilder', '~> 2.5'

# Async
# gem 'redis', '~> 3.0'

# Deploy
# gem 'capistrano-rails', group: :development

# Linter
gem 'overcommit'
gem 'rubocop', '0.48', require: false

group :development, :test do
  # Debug
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'pry-rails'

  # Tests
  gem 'capybara', '~> 2.13'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
end

group :development do
  # Debug
  gem 'web-console', '>= 3.3.0'

  # Cache / Localhost
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
