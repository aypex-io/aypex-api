# By placing Aypex shared dependencies in this file and then loading
# it for each component's Gemfile, we can be sure that we're only testing just
# the one component of Aypex.
source "https://rubygems.org"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw]

%w[
  actionmailer actionpack actionview activejob activemodel activerecord
  activestorage activesupport railties
].each do |rails_gem|
  gem rails_gem, ENV.fetch("RAILS_VERSION", "~> 7.0.0"), require: false
end

platforms :jruby do
  gem "jruby-openssl"
end

platforms :ruby do
  if ENV["DB"] == "mysql"
    gem "mysql2"
  else
    gem "pg"
  end
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "database_cleaner-active_record"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "propshaft"
  gem "puma"
  gem "redis"
  gem "rails-controller-testing"
  gem "rspec-activemodel-mocks"
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "rspec-retry"
  gem "rswag-specs"
  gem "simplecov"
  gem "timecop"
  gem "webdrivers"
  gem "webmock"
end

group :test, :development do
  gem "awesome_print"
  gem "debug"
  gem "gem-release"
  gem "i18n-tasks"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "standard", "~> 1.0"
end

group :development do
  gem "solargraph"
  gem "erb_lint"
end

group :test do
  gem 'jsonapi-rspec'
  gem 'multi_json'
end

gem 'aypex', path: '../aypex'

gemspec
