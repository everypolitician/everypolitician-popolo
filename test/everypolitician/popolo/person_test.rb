require 'test_helper'

class PersonTest < Minitest::Test
  def popolo
    Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json')
  end

  def aadu
    popolo.persons.first
  end

  def aare
    popolo.persons.to_a[1]
  end

  def test_reading_popolo_people
    assert_instance_of Everypolitician::Popolo::People, popolo.persons
    assert_instance_of Everypolitician::Popolo::Person, aadu
  end

  def test_no_persons_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.persons.none?
  end

  def test_accessing_person_properties
    assert aadu.key?(:id)
    assert_equal 'bc584d7f-86a1-4c2d-97b4-081971d8a1fa', aadu[:id]
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
      links:           [{ note: 'twitter', url: 'https://twitter.com/bob' }]
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
    assert_equal aadu.name_at('2016-01-11'), 'Aadu Must'
    assert_equal 'Are Heinvee', aare.name_at('1990-06-01')

    person = Everypolitician::Popolo::Person.new(
      name:        'Bob',
      other_names: [
        { name: 'Robert', start_date: '1989-01-01', end_date: '1999-12-31' },
        { name: 'Bobby', start_date: '1989-01-01', end_date: '2012-12-31' },
      ]
    )

    assert_raises Everypolitician::Popolo::Person::Error do
      person.name_at('1996-01-01')
    end
  end

  def test_person_facebook
    assert_nil aare.facebook
    assert_equal 'https://facebook.com/100000744087901', aadu.facebook
  end

  def test_person_identifier
    assert_equal '233ac42e-573c-400e-8568-0ac3d4c107f9', aadu.identifier('riigikogu')
    assert_equal 'Q12358062', aadu.identifier('wikidata')
  end

  def test_person_wikidata
    assert_equal 'Q12358062', aadu.identifier('wikidata')
  end

  def test_person_no_wikidata
    assert_nil aare.wikidata
  end

  def test_person_contacts
    assert_equal '6316629', aadu.contact('phone')
    assert_equal '6316629', aadu.phone
    assert_equal 'Aadu.Must@riigikogu.ee', aadu.email
  end

  def test_person_no_contacts
    assert_equal nil, aare.contact('phone')
    assert_equal nil, aare.phone
    assert_equal nil, aare.fax
  end

  def test_person_sort_name
    assert_equal 'Aadu Must', aadu.sort_name
    assert_equal 'Are', aare.sort_name
  end

  def test_person_email
    assert_equal nil, aare.email
    assert_equal 'Aadu.Must@riigikogu.ee', aadu.email
  end

  def test_person_image
    assert_equal nil, aare.image
    assert_equal 'http://www.riigikogu.ee/wpcms/wp-content/uploads/ems/temp/68d27c93-66c5-4255-9af3-457a8b5ce77c.jpg', aadu.image
  end

  def test_person_gender
    assert_equal nil, aare.gender
    assert_equal 'male', aadu.gender
  end

  def test_person_equality_based_on_id
    person = Everypolitician::Popolo::Person.new(id: 'bc584d7f-86a1-4c2d-97b4-081971d8a1fa')
    assert_equal aadu, person
  end

  def test_person_equality_based_on_class
    organization = Everypolitician::Popolo::Organization.new(id: 'bc584d7f-86a1-4c2d-97b4-081971d8a1fa')
    refute_equal aadu, organization
  end

  def test_persons_subtraction
    all_people = Everypolitician::Popolo::People.new([aadu.document.to_h, aare.document.to_h])
    just_person_1 = Everypolitician::Popolo::People.new([aadu.document.to_h])
    assert_equal [Everypolitician::Popolo::Person.new(aare.document.to_h)], all_people - just_person_1
  end

  def test_honorific_prefix
    assert_nil aare.honorific_prefix
    assert_equal 'Dr', aadu.honorific_prefix
  end

  def test_honorific_suffix
    assert_nil aare.honorific_suffix
    assert_equal 'PhD', aadu.honorific_suffix
  end

  def test_person_memberships
    memberships = aadu.memberships
    assert_equal 2, memberships.size
    assert_equal '2013-10-31', memberships.first.end_date
  end
end
