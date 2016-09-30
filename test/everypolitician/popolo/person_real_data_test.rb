require 'test_helper'

class PersonTest < Minitest::Test
  def persons
    @persons ||= Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json').persons
  end

  def person_one
    persons.first
  end

  def person_two
    persons.select { |p| p.id == '32f14e80-cf5b-407c-a6a6-95fbd7f2851c' }.first
  end

  def test_person_has_contact_details
    contact = [{ type: 'email', value: 'Aadu.Must@riigikogu.ee' }, { type: 'phone', value: '6316629' }]
    assert_equal person_one.contact_details, contact
  end

  def test_person_has_family_name
    family_name = 'Nestor'
    assert_equal family_name, person_two.family_name
  end

  def test_person_has_given_name
    given_name = 'Eiki'
    assert_equal given_name, person_two.given_name
  end

  def test_person_has_identifiers
    identifier = { identifier: '3659', scheme: 'pace' }
    assert_equal 6, person_two.identifiers.count
    assert_includes person_two.identifiers, identifier
  end

  def test_person_has_images
    image = { url: 'https://upload.wikimedia.org/wikipedia/commons/1/15/SDE_Eiki_Nestor.jpg' }
    assert_equal 2, person_two.images.count
    assert_includes person_two.images, image
  end

  def test_person_has_links
    link = { note: 'facebook', url: 'https://facebook.com/100000658185044' }
    assert_equal 9, person_two.links.count
    assert_includes person_two.links, link
  end

  def test_person_has_other_names
    other_name = { lang: 'et', name: 'Eiki Nestor', note: 'multilingual' }
    assert_equal 24, person_two.other_names.count
    assert_includes person_two.other_names, other_name
  end

  def test_person_has_sources
    source = [{ url: 'http://www.riigikogu.ee/riigikogu/koosseis/riigikogu-liikmed/saadik/233ac42e-573c-400e-8568-0ac3d4c107f9/Aadu-Must' }]
    assert_equal person_one.sources, source
  end
end
