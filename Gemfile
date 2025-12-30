source 'https://rubygems.org'

gem 'rails'

gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'commonmarker'
gem 'fetch-api'
gem 'image_processing'
gem 'importmap-rails'
gem 'marksmith'
gem 'pg'
gem 'propshaft'
gem 'puma'
gem 'sentry-rails'
gem 'solid_cable'
gem 'solid_cache'
gem 'solid_queue'
gem 'stackprof' # Sentry Profiling
gem 'stimulus-rails'
gem 'thruster'
gem 'turbo-rails'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'debug', require: 'debug/prelude'
  gem 'rubocop-erb', require: false
  gem 'rubocop-rails-omakase', require: false
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'climate_control'
  gem 'minitest', '< 6', require: false # https://github.com/rails/rails/issues/56406
  gem 'selenium-webdriver'
  gem 'webmock'
end
