require 'test_helper'

class Everypolitician::PopoloTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Everypolitician::Popolo::VERSION
  end

  def test_reading_popolo_people
    popolo = Everypolitician::Popolo::JSON.new(persons: [{id: '123', name: 'Bob'}])
    assert_instance_of Everypolitician::Popolo::People, popolo.persons
    person = popolo.persons.first
    assert_instance_of Everypolitician::Popolo::Person, person
  end

  def test_accessing_person_properties
    popolo = Everypolitician::Popolo::JSON.new(persons: [{id: '123', name: 'Bob'}])
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
end
