require_relative "lib/aypex/api/version"

Gem::Specification.new do |spec|
  spec.name        = "aypex-api"
  spec.version     = Aypex::Api::VERSION
  spec.authors     = ["Matthew Kennedy"]
  spec.email       = ["m.kennedy@me.com"]
  spec.homepage    = "https://github.com/aypex-io/aypex-api"
  spec.summary     = "Full API Kit for Aypex"
  spec.description = "Full API Kit for Aypex"
  spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aypex-io/aypex-api/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "https://github.com/aypex-io/aypex-emails/releases/tag/v#{spec.version}"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"

  spec.add_dependency 'bcrypt'
  spec.add_dependency 'doorkeeper'
  spec.add_dependency 'jsonapi-serializer'
  spec.add_dependency 'aypex'
end
