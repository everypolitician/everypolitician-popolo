require 'test_helper'

class PersonTest < Minitest::Test
  def fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def people
    @ppl ||= Everypolitician::Popolo.read(fixture).persons
  end

  def aadu
    people.find_by(name: 'Aadu Must')
  end

  def taavi
    people.find_by(name: 'Taavi Rõivas')
  end

  def eiki
    people.find_by(name: 'Eiki Nestor')
  end

  def etti
    people.find_by(name: 'Etti Kagarov')
  end

  def test_people_class
    assert_instance_of Everypolitician::Popolo::People, people
  end

  def test_class
    assert_instance_of Everypolitician::Popolo::Person, people.first
  end

  def test_id_attribute
    assert_equal '6b71eefc-413d-4db6-88f0-d7ff845ebaf1', taavi[:id]
  end

  def test_id_method
    assert_equal '6b71eefc-413d-4db6-88f0-d7ff845ebaf1', taavi.id
  end

  def test_name
    assert_equal 'Taavi Rõivas', taavi.name
    assert_equal 'Taavi Rõivas', taavi.name_at('2015-01-01')
  end

  def test_twitter
    assert_equal 'taaviroivas', taavi.twitter
    assert_equal nil, eiki.twitter
  end

  def test_facebook
    assert_equal 'https://facebook.com/100000658185044', eiki.facebook
    assert_equal nil, taavi.facebook
  end

  # TODO: switch this test to be against live data
  def test_name_at
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

  def test_identifier
    assert_equal '1105987868', taavi.identifier('gnd')
  end

  def test_wikidata
    assert_equal 'Q3785077', taavi.wikidata
  end

  def test_contacts
    assert_equal '6316301', eiki.contact('phone')
    assert_equal '6316301', eiki.phone
    assert_equal nil, eiki.fax
  end

  def test_no_contacts
    assert_equal nil, taavi.contact('phone')
    assert_equal nil, taavi.phone
    assert_equal nil, taavi.fax
  end

  def test_sort_name
    assert_equal nil, taavi['sort_name']
    assert_equal 'Taavi Rõivas', taavi.sort_name
  end

  def test_family_name
    assert_equal 'Nestor', eiki.family_name
  end

  def test_given_name
    assert_equal 'Eiki', eiki.given_name
  end

  def test_email
    assert_equal 'Taavi.Roivas@riigikogu.ee', taavi.email
  end

  def test_image
    assert_equal 'http://www.riigikogu.ee/wpcms/wp-content/uploads/ems/temp/8a941c7a-8333-484b-a720-8207dee2e4cc.jpg', eiki.image
    assert_equal nil, etti.image
  end

  def test_gender
    assert_equal 'male', taavi.gender
    assert_equal nil, etti.gender
  end

  def test_equality
    assert_equal taavi, taavi
    refute_equal taavi, etti
  end

  def test_persons_subtraction
    person1 = { id: '123', name: 'Alice' }
    person2 = { id: '456', name: 'Bob', gender: 'male' }
    all_people = Everypolitician::Popolo::People.new([person1, person2])
    just_person_1 = Everypolitician::Popolo::People.new([person1])
    assert_equal [Everypolitician::Popolo::Person.new(person2)], all_people - just_person_1
  end

  def test_honorific_prefix
    assert_equal nil, taavi.honorific_prefix
    person = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', honorific_prefix: 'Dr')
    assert_equal 'Dr', person.honorific_prefix
  end

  def test_honorific_suffix
    assert_equal nil, taavi.honorific_suffix
    person = Everypolitician::Popolo::Person.new(id: '123', name: 'Bob', honorific_suffix: 'PhD')
    assert_equal 'PhD', person.honorific_suffix
  end

  def test_memberships
    assert_equal 2, etti.memberships.size
    assert_equal '2014-03-27', etti.memberships.first.start_date
  end

  def test_images
    image = { url: 'https://upload.wikimedia.org/wikipedia/commons/1/15/SDE_Eiki_Nestor.jpg' }
    assert_equal 2, eiki.images.count
    assert_includes eiki.images, image
  end

  def test_sources
    source = { url: 'http://www.riigikogu.ee/riigikogu/koosseis/riigikogu-liikmed/saadik/233ac42e-573c-400e-8568-0ac3d4c107f9/Aadu-Must' }
    assert_equal aadu.sources.first, source
  end

  def test_other_names
    other_name = { lang: 'et', name: 'Eiki Nestor', note: 'multilingual' }
    assert_equal 24, eiki.other_names.count
    assert_includes eiki.other_names, other_name
  end

  def test_links
    link = { note: 'facebook', url: 'https://facebook.com/100000658185044' }
    assert_equal 9, eiki.links.count
    assert_includes eiki.links, link
  end
end
