require "rubygems"
require "rake"
require "rake/testtask"
require "rspec/core/rake_task"
require "aypex/api/testing_support/api_rake"

RSpec::Core::RakeTask.new

task default: :spec

desc "Generates a dummy app for testing"
task :test_app do
  ENV["LIB_NAME"] = "aypex/api"
  Rake::Task["api:test_app"].invoke
end

namespace :rswag do
  namespace :specs do
    desc "Generate Swagger JSON files from integration specs"
    RSpec::Core::RakeTask.new("swaggerize") do |t|
      t.pattern = ENV.fetch(
        "PATTERN",
        "spec/integration/**/*_spec.rb"
      )

      t.rspec_opts = ["--format Rswag::Specs::SwaggerFormatter", "--order defined"]
    end
  end
end
