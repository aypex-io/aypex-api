[![CI Tests](https://github.com/aypex-io/aypex-api/actions/workflows/ci.yml/badge.svg)](https://github.com/aypex-io/aypex-api/actions/workflows/ci.yml)
[![SNYK Gem Dependency](https://github.com/aypex-io/aypex-api/actions/workflows/snyk.yml/badge.svg)](https://github.com/aypex-io/aypex-api/actions/workflows/snyk.yml)
[![Standard Ruby Format](https://github.com/aypex-io/aypex-api/actions/workflows/standard_rb.yml/badge.svg)](https://github.com/aypex-io/aypex-api/actions/workflows/standard_rb.yml)

# Aypex::Api

The API pack for Aypex

## Installation

Add this line to your existing Aypex application's Gemfile:
```ruby
gem "aypex-api"
```

And then execute:
```bash
bundle
```

And then run the Aypex::Api install command:
```bash
bin/rails g aypex:api:install
```

## Testing

```bash
bundle exec rake test_app
```

```bash
bundle exec rspec spec
```

## Generating Swagger Docs
```bash
bundle exec rake rswag:specs:swaggerize
```

## License
The gem is available as open source under the terms of the [MIT License](https://github.com/aypex-io/aypex-api/blob/main/MIT-LICENSE).
