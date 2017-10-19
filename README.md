# Sequel::Postgres::SchemaData

Dump and load data from specific schema in CSV format

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-pg_schema_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-pg_schema_data

## Usage

```ruby
db = Sequel.connect ...

db.extension :pg_schema_data

db.dump_schema_data :public, 'path/to/data', ignore: [:table_name]

db.load_schema_data :public, 'path/to/data'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/sequel-pg_schema_data.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
