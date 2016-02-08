require 'test_helper'

class Everypolitician::PopoloTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Everypolitician::Popolo::VERSION
  end

  def test_reading_popolo_people
    popolo = Everypolitician::Popolo::JSON.new(persons: [{ id: '123', name: 'Bob' }])
    assert_instance_of Everypolitician::Popolo::People, popolo.persons
    person = popolo.persons.first
    assert_instance_of Everypolitician::Popolo::Person, person
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

  def test_parsing_string
    popolo = Everypolitician::Popolo.parse('{"persons":[{"id":"123", "name": "Bob"}]}')
    assert_equal 1, popolo.persons.count
    person = popolo.persons.first
    assert_equal '123', person.id
    assert_equal 'Bob', person.name
  end

  def test_reading_file
    popolo = Everypolitician::Popolo.read('test/fixtures/ep-popolo-v1.0.json')
    assert_equal 1, popolo.persons.count
    person = popolo.persons.first
    assert_equal 'person/123', person.id
    assert_equal 'Bob Smith', person.name
  end

  def test_reading_popolo_organizations
    popolo = Everypolitician::Popolo::JSON.new(organizations: [{ id: '123', name: 'ACME' }])
    assert_instance_of Everypolitician::Popolo::Organizations, popolo.organizations
    organization = popolo.organizations.first
    assert_instance_of Everypolitician::Popolo::Organization, organization
  end

  def test_accessing_organization_properties
    popolo = Everypolitician::Popolo::JSON.new(organizations: [{ id: '123', name: 'ACME' }])
    organization = popolo.organizations.first
    assert_equal '123', organization.id
    assert_equal 'ACME', organization.name
  end

  def test_person_equality_based_on_id
    person1 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob')
    person2 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', gender: 'male')
    assert_equal person1, person2
  end

  def test_organization_equality_based_on_id
    org1 = Everypolitician::Popolo::Organization.new(id: 'abc', name: 'ACME')
    org2 = Everypolitician::Popolo::Organization.new(id: 'abc', name: 'ACME')
    assert_equal org1, org2
  end
end
