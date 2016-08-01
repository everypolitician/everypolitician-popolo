require 'test_helper'

class PopoloTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Everypolitician::Popolo::VERSION
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
end
