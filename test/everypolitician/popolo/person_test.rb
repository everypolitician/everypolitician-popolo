require 'test_helper'

class Everypolitician::PersonTest < Minitest::Test
  def test_reading_popolo_people
    popolo = Everypolitician::Popolo::JSON.new(persons: [{ id: '123', name: 'Bob' }])
    assert_instance_of Everypolitician::Popolo::People, popolo.persons
    person = popolo.persons.first
    assert_instance_of Everypolitician::Popolo::Person, person
  end

  def test_no_persons_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.persons.none?
  end

  def test_accessing_person_properties
    popolo = Everypolitician::Popolo::JSON.new(persons: [{ id: '123', name: 'Bob' }])
    person = popolo.persons.first
    assert person.key?(:id)
    assert_equal '123', person[:id]
  end

  def test_person_twitter_contact_details
    person = Everypolitician::Popolo::Person.new(
      contact_details: [{ type: 'twitter', value: 'bob' }]
    )
    assert_equal 'bob', person.twitter
  end

  def test_person_twitter_links
    person = Everypolitician::Popolo::Person.new(
      links: [{ note: 'twitter', url: 'https://twitter.com/bob' }]
    )
    assert_equal 'https://twitter.com/bob', person.twitter
  end

  def test_person_contact_details_and_twitter_links
    person = Everypolitician::Popolo::Person.new(
      contact_details: [{ note: 'cell', value: '+1-555-555-0100' }],
      links: [{ note: 'twitter', url: 'https://twitter.com/bob' }]
    )
    assert_equal 'https://twitter.com/bob', person.twitter
  end

  def test_accessing_basic_person_attributes
    person = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', other_names: [])
    assert_equal '123', person.id
    assert_equal 'Bob', person.name
    assert_equal [], person.other_names
  end

  def test_person_name_at
    person = Everypolitician::Popolo::Person.new(name: 'Bob')
    assert_equal person.name_at('2016-01-11'), 'Bob'
    person = Everypolitician::Popolo::Person.new(
      name: 'Bob',
      other_names: [
        { name: 'Robert', start_date: '1989-01-01', end_date: '1999-12-31' }
      ]
    )
    assert_equal 'Robert', person.name_at('1990-06-01')

    person = Everypolitician::Popolo::Person.new(
      name: 'Bob',
      other_names: [
        { name: 'Robert', start_date: '1989-01-01', end_date: '1999-12-31' },
        { name: 'Bobby', start_date: '1989-01-01', end_date: '2012-12-31' }
      ]
    )

    assert_raises Everypolitician::Popolo::Person::Error do
      person.name_at('1996-01-01')
    end
  end

  def test_person_facebook
    person = Everypolitician::Popolo::Person.new({})
    assert_nil person.facebook
    person = Everypolitician::Popolo::Person.new(
      links: [{ note: 'facebook', url: 'https://www.facebook.com/bob' }]
    )
    assert_equal 'https://www.facebook.com/bob', person.facebook
  end

  def test_person_identifier
    person = Everypolitician::Popolo::Person.new(
      identifiers: [
        { scheme: 'foo', identifier: 'bar' },
        { scheme: 'wikidata', identifier: 'zap' }
      ]
    )

    assert_equal 'bar', person.identifier('foo')
    assert_equal 'zap', person.identifier('wikidata')
  end

  def test_person_wikidata
    person = Everypolitician::Popolo::Person.new({})
    assert_nil person.wikidata
    person = Everypolitician::Popolo::Person.new(
      identifiers: [{ scheme: 'wikidata', identifier: 'Q153149' }]
    )
    assert_equal 'Q153149', person.wikidata
  end

  def test_person_contacts
    person = Everypolitician::Popolo::Person.new(
      contact_details: [
        { type: "phone", value: "9304832" },
        { type: "fax",   value: "9304833" },
      ]
    )
    assert_equal '9304832', person.contact('phone')
    assert_equal '9304832', person.phone
    assert_equal '9304833', person.fax
  end

  def test_person_no_contacts
    person = Everypolitician::Popolo::Person.new({})
    assert_equal nil, person.contact('phone')
    assert_equal nil, person.phone
    assert_equal nil, person.fax
  end

  def test_person_sort_name
    person = Everypolitician::Popolo::Person.new(name: 'Bob')
    assert_equal 'Bob', person.sort_name
    person = Everypolitician::Popolo::Person.new(name: 'Bob', sort_name: 'Robert')
    assert_equal 'Robert', person.sort_name
  end

  def test_person_email
    person = Everypolitician::Popolo::Person.new(name: 'Bob')
    assert_equal nil, person.email
    person = Everypolitician::Popolo::Person.new(name: 'Bob', email: 'bob@example.org')
    assert_equal 'bob@example.org', person.email
  end

  def test_person_image
    person = Everypolitician::Popolo::Person.new(name: 'Bob')
    assert_equal nil, person.image
    person = Everypolitician::Popolo::Person.new(name: 'Bob', image: 'http://example.org/img.jpeg')
    assert_equal 'http://example.org/img.jpeg', person.image
  end

  def test_person_gender
    person = Everypolitician::Popolo::Person.new(name: 'Bob')
    assert_equal nil, person.gender
    person = Everypolitician::Popolo::Person.new(name: 'Bob', gender: 'male')
    assert_equal 'male', person.gender
  end

  def test_person_equality_based_on_id
    person1 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob')
    person2 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', gender: 'male')
    assert_equal person1, person2
  end

  def test_persons_subtraction
    person1 = { id: '123', name: 'Alice' }
    person2 = { id: '456', name: 'Bob', gender: 'male' }
    all_people = Everypolitician::Popolo::People.new([person1, person2])
    just_person_1 = Everypolitician::Popolo::People.new([person1])
    assert_equal [Everypolitician::Popolo::Person.new(person2)], all_people - just_person_1
  end

  def test_honorifics
    person1 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', honorific_prefix: 'Dr')
    person2 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob')
    assert_equal 'Dr', person1.honorific_prefix
    assert_nil person2.honorific_prefix
  end

end
