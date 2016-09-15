require 'test_helper'

class PersonTest < Minitest::Test
  def people
    @people ||= Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json').persons
  end

  def peeter
    @peeter ||= people.select { |p| p.id == '5db703d7-bdb8-4d14-b2dd-1100aa9c1671' }.first
  end

  def kaja
    @kaja ||= people.select { |p| p.id == '228ba218-43db-4b81-9a34-44ec36b98b24' }.first
  end

  def aadu
    @aadu ||= people.select { |p| p.id == 'bc584d7f-86a1-4c2d-97b4-081971d8a1fa' }.first
  end

  def popolo
    Everypolitician::Popolo::JSON.new(persons: [{ id: '123', name: 'Bob' }])
  end

  def bob
    popolo.persons.first
  end

  def test_reading_popolo_people
    assert_instance_of Everypolitician::Popolo::People, people
    assert_instance_of Everypolitician::Popolo::Person, peeter
  end

  def test_no_persons_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.persons.none?
  end

  def test_accessing_person_properties
    assert peeter.key?(:id)
    assert_equal '5db703d7-bdb8-4d14-b2dd-1100aa9c1671', peeter.id
  end

  def test_person_twitter_contact_details
    kaja_contact_details = { type: 'twitter', value: 'kajakallas' }
    assert_equal kaja_contact_details, kaja.contact_details.first
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
    assert_equal '5db703d7-bdb8-4d14-b2dd-1100aa9c1671', peeter.id
    assert_equal 'Peeter Kreitzberg', peeter.name
    peeter_other_names = {:lang=>"ca", :name=>"Peeter Kreitzberg", :note=>"multilingual"}
    assert_equal peeter_other_names, peeter.other_names.first
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
    assert_nil peeter.facebook
    assert_equal 'https://facebook.com/100000744087901', aadu.facebook
  end

  def test_person_identifier
    assert_equal 'Q3741792', peeter.identifier('wikidata')
    assert_nil peeter.identifier('twitter')
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
    assert_equal nil, peeter.contact('phone')
    assert_equal nil, peeter.phone
    assert_equal nil, peeter.fax
  end

  def test_person_sort_name
    assert_equal 'Peeter Kreitzberg', peeter.sort_name
  end

  def test_person_email
    assert_equal nil, bob.email
    person = Everypolitician::Popolo::Person.new(name: 'Bob', email: 'bob@example.org')
    assert_equal 'bob@example.org', person.email
  end

  def test_person_image
    assert_equal nil, bob.image
    assert_equal 'https://upload.wikimedia.org/wikipedia/commons/1/1c/SDE_Peeter_Kreitzberg.jpg', peeter.image
  end

  def test_person_gender
    assert_equal nil, bob.gender
    assert_equal 'male', peeter.gender
  end

  def test_person_equality_based_on_id
    person2 = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', gender: 'male')
    assert_equal bob, person2
  end

  def test_person_equality_based_on_class
    refute_equal bob, String
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
    peeter_membership_organization_id = '1ba661a9-22ad-4d0f-8a60-fe8e28f2488c'
    assert_equal peeter_membership_organization_id, peeter.memberships.first.organization_id
  end

  def test_person_links
    peeter_link = { note: 'Wikipedia (commons)', url: 'https://commons.wikipedia.org/wiki/Category:Peeter_Kreitzberg' }
    assert_equal peeter_link, peeter.links.first
  end

  def test_person_birth_date
    assert_equal '1948-12-14', peeter.birth_date
  end

  def test_person_death_date
    assert_equal '2011-11-03', peeter.death_date
  end

  def test_person_images
    peeter_image = { url: 'https://upload.wikimedia.org/wikipedia/commons/1/1c/SDE_Peeter_Kreitzberg.jpg' }
    assert_equal peeter_image, peeter.images.first
  end

  def test_person_family_name
    assert_equal 'Kallas', kaja.family_name
  end

  def test_person_given_name
    assert_equal 'Aadu', aadu.given_name
  end

  def test_person_sources
    aadu_source = { url: 'http://www.riigikogu.ee/riigikogu/koosseis/riigikogu-liikmed/saadik/233ac42e-573c-400e-8568-0ac3d4c107f9/Aadu-Must' }
    assert_equal aadu_source, aadu.sources.first
  end
end
