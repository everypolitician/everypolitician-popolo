# Everypolitician::Popolo

[EveryPolitician](http://everypolitician.org) provides its data in [Popolo](http://www.popoloproject.com/) format. If you want to interact with this data from Ruby then this library makes that task simpler.

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

You can download a Popolo file manually from [EveryPolitician](http://everypolitician.org/)
(although there's [another library](#see-also-everypolitician-ruby)
if you want to automate that). The following example uses [Åland Lagting](https://github.com/everypolitician/everypolitician-data/raw/master/data/Aland/Lagting/ep-popolo-v1.0.json) (which is the legislature of the Åland islands,
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
```

You can also find individual records or collections based on their attributes:

```ruby
popolo.persons.find_by(name: "Aaltonen Carina")
    # => #<Everypolitician::Popolo::Person:0x0000000237dfc8
    #      @document={:id=>"0c705344-23aa-4fa2-9391-af41c1c775b7",
    #                 :identifiers=>[{:identifier=>"Q4934081", :scheme=>"wikidata"}],
    #                 :name=>"Aaltonen Carina"}>

popolo.organizations.where(classification: "party")
    # => [
    #      <Everypolitician::Popolo::Organization:0x000000035779e0
    #       @document={:classification=>"party",
    #                  :id=>"123",
    #                  :name=>"Sunripe Tomato Party"}>,
    #      <Everypolitician::Popolo::Organization:0x000000035779e1
    #       @document={:classification=>"party",
    #                  :id=>"456",
    #                  :name=>"The Greens"}>
    #    ]
```

### See also: everypolitician-ruby

In the example above, the Popolo data comes from a downloaded file
(`ep-popolo-v1.0.json`), which is the kind of file you can get from the 
[EveryPolitician website](http://everypolitician.org).
But your Ruby application can also interact directly with the EveryPolitician
data using the
[everypolitician-ruby gem](http://github.com/everypolitician/everypolitician-ruby),
so you don't need to handle JSON files at all. The data the gem returns is in
`Everypolitician::Popolo` format.

```ruby
require 'everypolitician'

australia = Everypolitician::Index.new.country('Australia')
australia.code # => "AU"
senate = australia.legislature('Senate')
senate.persons.find_by(name: "Aden Ridgeway")
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/everypolitician/everypolitician-popolo.

## Releasing

After you've added a new feature or fixed a bug you should release the gem to rubygems.org.

TravisCI will take care of this for us as long as the release is tagged.

For example, to release to release version `0.12.0`:

    git tag -a -m "everypolitician-popolo v0.12.0" v0.12.0
    git push origin --tags

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
