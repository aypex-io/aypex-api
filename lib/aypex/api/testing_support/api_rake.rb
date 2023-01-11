unless defined?(Aypex::InstallGenerator)
  require 'generators/aypex/install/install_generator'
end

require 'generators/aypex/dummy/dummy_generator'
require 'generators/aypex/dummy_model/dummy_model_generator'

desc 'Generates a dummy app for testing'
namespace :api do
  task :test_app, :user_class do |_t, args|
    args.with_defaults(user_class: 'Aypex::LegacyUser', install_storefront: 'false', install_admin: 'false')
    require ENV['LIB_NAME'].to_s

    ENV['DUMMY_PATH'] = 'tmp/dummy'
    ENV['RAILS_ENV'] = 'test'
    Rails.env = 'test'

    $stdout.puts "(1 of 3) Building dummy app for testing #{ENV.fetch('LIB_NAME', nil)}"
    Aypex::DummyGenerator.start ["--lib_name=#{ENV.fetch('LIB_NAME', nil)}", '--quiet']
    Aypex::InstallGenerator.start [
      "--lib_name=#{ENV.fetch('LIB_NAME', nil)}",
      '--auto-accept',
      '--migrate=false',
      '--seed=false',
      '--sample=false',
      '--quiet',
      '--copy_storefront=false',
      "--install_storefront=#{args[:install_storefront]}",
      "--install_admin=#{args[:install_admin]}",
      "--user_class=#{args[:user_class]}"
    ]

    $stdout.puts '(2 of 3) Setting up dummy database...'
    system('bin/rails db:environment:set RAILS_ENV=test')
    system('bundle exec rake db:drop db:create')
    Aypex::DummyModelGenerator.start
    system('bundle exec rake db:migrate')

    $stdout.puts '(2 of 3) Precompiling assets...'
    system('bundle exec rake assets:precompile')

    $stdout.puts 'Fin!'
  end

  task :seed do |_t|
    puts 'Seeding ...'
    system('bundle exec rake db:seed RAILS_ENV=test')
  end
end
