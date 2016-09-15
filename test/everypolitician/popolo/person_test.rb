require 'test_helper'

class PersonTest < Minitest::Test
  def people
    @people ||= Everypolitician::Popolo.read('test/fixtures/turkey-ep-popolo-v1.0.json').persons
  end

  def abdullah
    @abdullah ||= people.select { |p| p.id == '51704345-f3a1-4eae-912a-85a06bd14622' }.first
  end

  def ayse
    @ayse ||= people.select { |p| p.id == 'cd494a2c-9070-467a-89d8-8691337d730e' }.first
  end

  def abbas
    @abbas ||= people.select { |p| p.id == '8fd85a9f-6407-46f1-ba77-35d24b41a12a' }.first
  end

  def popolo
    Everypolitician::Popolo::JSON.new(persons: [{ id: '123', name: 'Bob' }])
  end

  def bob
    popolo.persons.first
  end

  def test_reading_popolo_people
    assert_instance_of Everypolitician::Popolo::People, people
    assert_instance_of Everypolitician::Popolo::Person, abdullah
  end

  def test_no_persons_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.persons.none?
  end

  def test_accessing_person_properties
    assert abdullah.key?(:id)
    assert_equal '51704345-f3a1-4eae-912a-85a06bd14622', abdullah.id
  end

  def test_person_twitter_contact_details
    abdullah_contact_details = { type: 'twitter', value: 'cbabdullahgul' }
    assert_equal abdullah_contact_details, abdullah.contact_details.first
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
    assert_equal '51704345-f3a1-4eae-912a-85a06bd14622', abdullah.id
    assert_equal 'Abdullah Gül', abdullah.name
    abdullah_other_names = { lang: 'af', name: 'Abdullah Gül', note: 'multilingual' }
    assert_equal abdullah_other_names, abdullah.other_names.first
  end

  def test_person_name_at
    assert_equal bob.name_at('2016-01-11'), 'Bob'
    person = Everypolitician::Popolo::Person.new(
      name:        'Bob',
      other_names: [
        { name: 'Robert', start_date: '1989-01-01', end_date: '1999-12-31' },
      ]
    )
    assert_equal 'Robert', person.name_at('1990-06-01')

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
    assert_nil abdullah.facebook
    assert_equal 'https://facebook.com/aysesula61', ayse.facebook
  end

  def test_person_identifier
    assert_equal 'Q20471212', ayse.identifier('wikidata')
    assert_nil abdullah.identifier('twitter')
  end

  def test_person_wikidata
    assert_equal 'Q20471212', ayse.identifier('wikidata')
  end

  def test_person_no_wikidata
    assert_nil bob.wikidata
  end

  def test_person_contacts
    person = Everypolitician::Popolo::Person.new(
      contact_details: [
        { type: 'phone', value: '9304832' },
        { type: 'fax',   value: '9304833' },
      ]
    )
    assert_equal '9304832', person.contact('phone')
    assert_equal '9304832', person.phone
    assert_equal '9304833', person.fax
  end

  def test_person_no_contacts
    assert_equal nil, abdullah.contact('phone')
    assert_equal nil, abdullah.phone
    assert_equal nil, abdullah.fax
  end

  def test_person_sort_name
    assert_equal 'Abdullah Gül', abdullah.sort_name
  end

  def test_person_email
    assert_equal nil, bob.email
    person = Everypolitician::Popolo::Person.new(name: 'Bob', email: 'bob@example.org')
    assert_equal 'bob@example.org', person.email
  end

  def test_person_image
    assert_equal nil, bob.image
    assert_equal 'https://upload.wikimedia.org/wikipedia/commons/9/91/Abdullah_Gül_2011-06-07.jpg', abdullah.image
  end

  def test_person_gender
    assert_equal nil, bob.gender
    assert_equal 'male', abdullah.gender
  end

  def test_person_equality_based_on_id
    person2 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', gender: 'male')
    assert_equal bob, person2
  end

  def test_person_equality_based_on_class
    refute_equal bob, abdullah
  end

  def test_persons_subtraction
    person1 = { id: '123', name: 'Alice' }
    person2 = { id: '456', name: 'Bob', gender: 'male' }
    all_people = Everypolitician::Popolo::People.new([person1, person2])
    just_person_1 = Everypolitician::Popolo::People.new([person1])
    assert_equal [Everypolitician::Popolo::Person.new(person2)], all_people - just_person_1
  end

  def test_honorific_prefix
    assert_nil bob.honorific_prefix
    person = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', honorific_prefix: 'Dr')
    assert_equal 'Dr', person.honorific_prefix
  end

  def test_honorific_suffix
    assert_nil bob.honorific_suffix
    person = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', honorific_suffix: 'PhD')
    assert_equal 'PhD', person.honorific_suffix
  end

  def test_person_memberships
    abdullah_membership_organization_id = '83911419-04ab-4add-a687-93a4e8845296'
    assert_equal abdullah_membership_organization_id, abdullah.memberships.first.organization_id
  end

  def test_person_links
    abdullah_link = { note: 'Wikipedia (af)', url: 'https://af.wikipedia.org/wiki/Abdullah_Gül' }
    assert_equal abdullah_link, abdullah.links.first
  end

  def test_person_birth_date
    assert_equal '1950-10-29', abdullah.birth_date
  end

  def test_person_death_date
    assert_equal '1975-08-26', abbas.death_date
  end

  def test_person_images
    abdullah_image = { url: 'https://upload.wikimedia.org/wikipedia/commons/9/91/Abdullah_Gül_2011-06-07.jpg' }
    assert_equal abdullah_image, abdullah.images.first
  end

  def test_person_family_name
    assert_equal 'Gül', abdullah.family_name
  end

  def test_person_given_name
    assert_equal 'Abdullah', abdullah.given_name
  end
end
