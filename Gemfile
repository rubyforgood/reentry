source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.7'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'immutable-struct'
gem 'nokogiri'
gem 'geocoder'
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'devise', '~> 4.6', '>= 4.6.2'

group :development, :test do
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'mocha'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'minitest'
  gem 'minitest-rails'
  gem 'minitest-spec-rails'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
