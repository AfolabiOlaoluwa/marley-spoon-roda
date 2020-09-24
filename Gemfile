# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'contentful_model', '~> 1.3'           # ActiveModel-like wrapper for the Contentful SDKs
gem 'roda', '~> 3.36'                      # Roda web framework
gem 'tilt', '~> 2.0', '>= 2.0.10'          # Templating engine
gem 'erubi', '~> 1.9'                      # Template syntax
gem 'puma', '~> 5.0'                       # Web application server
gem 'rack-unreloader', '~> 1.7'            # Rack middleware app file reloader
gem 'refrigerator', '~> 1.2'               # Use to freeze sets of classes in production

group :test do
  gem 'capybara'
  gem 'minitest', '>= 5.7.0'
  gem 'minitest-hooks', '>= 1.1.0'
  gem "minitest-global_expectations"
  gem "warning"
  gem 'pry'
end

group :development do
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-rspec'
end
