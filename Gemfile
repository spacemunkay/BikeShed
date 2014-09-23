source 'https://rubygems.org'

gem 'rails', '3.2.19'

gem 'netzke-cancan'
gem 'netzke-core'
gem 'netzke-basepack'


gem 'acts_as_loggable', :git => 'https://github.com/spacemunkay/acts_as_loggable.git'
gem 'bootstrap-will_paginate'
gem 'cancan'
gem 'decent_exposure', '~> 1.0.1'
gem 'devise', '~> 2.0.4'
gem 'haml-rails'
gem 'jquery-rails'
gem 'pg', '~> 0.17.1'
gem 'will_paginate'
gem 'jbuilder'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'sprockets-rails', '=2.0.0.backport1'
  gem 'sprockets', '=2.2.2.backport2'
  gem 'sass-rails', github: 'guilleiguaran/sass-rails', branch: 'backport'
  gem 'bootstrap-sass'
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'faker'
end

group :test do
# gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara', '~> 2.2.1'
  gem 'poltergeist', '~> 1.5.0'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'launchy', '~> 2.4.2'
  gem 'spork'
  #guard dependency for Mac OS 10
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-spork'
  gem 'guard-rspec'
end
