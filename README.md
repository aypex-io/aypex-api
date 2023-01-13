[![Aypex::Api CI](https://github.com/aypex-io/aypex-api/actions/workflows/ci.yml/badge.svg)](https://github.com/aypex-io/aypex-api/actions/workflows/ci.yml)
[![Standard RB](https://github.com/aypex-io/aypex-api/actions/workflows/standard_rb_core.yml/badge.svg)](https://github.com/aypex-io/aypex-api/actions/workflows/standard_rb_core.yml)

# Aypex::Api

The API pack for Aypex


## Installation

Create a new rails app
```bash
rails new [app_name] --database=postgresql -a propshaft
```

Add this line to your application's Gemfile:

```ruby
gem "aypex"
gem "aypex-api"
```

And then execute:
```bash
bundle
```

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
