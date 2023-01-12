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

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
