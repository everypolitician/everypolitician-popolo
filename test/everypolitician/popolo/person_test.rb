require 'test_helper'

class PersonTest < Minitest::Test
  def people
    Everypolitician::Popolo.read('test/fixtures/turkey-ep-popolo-v1.0.json').persons
  end

  def abdullah
    @abdullah ||= people.select { |p| p.id == '51704345-f3a1-4eae-912a-85a06bd14622' }.first
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

  def test_person_family_name
    assert_equal 'Gül', abdullah.family_name
  end

  def test_person_given_name
    assert_equal 'Abdullah', abdullah.given_name
  end

  def test_person_identifiers
    abdullah_identifier = { identifier: 'abdullah_gül', scheme: 'everypolitician_legacy' }
    assert_equal abdullah_identifier, abdullah.identifiers.first
  end

  def test_person_images
    abdullah_image = { url: 'https://upload.wikimedia.org/wikipedia/commons/9/91/Abdullah_Gül_2011-06-07.jpg' }
    assert_equal abdullah_image, abdullah.images.first
  end

  def test_person_other_names
    abdullah_other_names = { lang: 'af', name: 'Abdullah Gül', note: 'multilingual' }
    assert_equal abdullah_other_names, abdullah.other_names.first
  end

  def test_person_sources
    assert_nil abdullah.sources
  end

  def test_person_email
    assert_nil abdullah.email
  end

  def test_person_image
    abdullah_image = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Abdullah_Gül_2011-06-07.jpg'
    assert_equal abdullah_image, abdullah.image
  end

  def test_person_gender
    assert_equal 'male', abdullah.gender
  end

  def test_person_birth_date
    assert_equal '1950-10-29', abdullah.birth_date
  end

  def test_person_death_date
    assert_nil abdullah.death_date
  end

  def test_person_honorific_prefix
    assert_nil abdullah.honorific_prefix
  end

  def test_person_honorifix_suffix
    assert_nil abdullah.honorific_suffix
  end

  def test_person_links
    abdullah_link = { note: 'Wikipedia (af)', url: 'https://af.wikipedia.org/wiki/Abdullah_Gül' }
    assert_equal abdullah_link, abdullah.links.first
  end

  def test_person_contact_details
    abdullah_contact_details = { type: 'twitter', value: 'cbabdullahgul' }
    assert_equal abdullah_contact_details, abdullah.contact_details.first
  end

  def test_person_phone
    assert_nil abdullah.phone
  end

  def test_person_fax
    assert_nil abdullah.fax
  end

  def test_person_twitter
    assert_equal 'cbabdullahgul', abdullah.twitter
  end

  def test_person_facebook
    assert_nil abdullah.facebook
  end

  def test_person_wikidata
    assert_equal 'Q42852', abdullah.wikidata
  end

  def test_person_sort_name
    assert_equal 'Abdullah Gül', abdullah.sort_name
  end

  def test_person_memberships
    assert_equal '83911419-04ab-4add-a687-93a4e8845296', abdullah.memberships.first.organization_id
  end
end
