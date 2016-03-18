# Everypolitician::Popolo

[EveryPolitician](http://everypolitician.org) provides its data in [Popolo](http://www.popoloproject.com/) format. If you want to interact with this data from Ruby then this library should make that task simpler.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'everypolitician-popolo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install everypolitician-popolo

## Usage

You'll need to download a Popolo file from [EveryPolitician](http://everypolitician.org/). The following example uses [Åland Lagting](https://github.com/everypolitician/everypolitician-data/raw/master/data/Aland/Lagting/ep-popolo-v1.0.json) (which is the legislature of the Åland islands,
available as JSON data from the
[EveryPolitician page for Åland](http://everypolitician.org/aland/)).

First you'll need to require the library and read in a file from disk.

```ruby
require 'everypolitician/popolo'
popolo = Everypolitician::Popolo.read('ep-popolo-v1.0.json')
```

All Popolo classes used by EveryPolitician are implemented:

* [Person](http://www.popoloproject.com/specs/person.html)
* [Organization](http://www.popoloproject.com/specs/organization.html)
* [Area](http://www.popoloproject.com/specs/area.html)
* [Event](http://www.popoloproject.com/specs/event.html)
* [Membership](http://www.popoloproject.com/specs/membership.html)

There are methods defined for each property on a class, e.g. for a Person:

```
popolo.persons.count # => 47
person = popolo.persons.first
person.id # => "e3aab23e-a883-4763-be0d-92e5936024e2"
person.name # => "Aaltonen Carina"
person.image # => "http://www.lagtinget.ax/files/aaltonen_carina.jpg"
person.wikidata # => "Q4934081"

popolo.persons.find_by(name: "Aaltonen Carina", wikidata: "Q4934081")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/everypolitician/everypolitician-popolo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
