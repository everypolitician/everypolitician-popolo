require 'test_helper'

class OrganizationTest < Minitest::Test
  def organizations
    @organizations ||= Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json').organizations
  end

  def organization_one
    organizations.select { |o| o[:id] == 'EKRE' }.first
  end

  def organization_two
    organizations.select { |o| o[:id] == '1ba661a9-22ad-4d0f-8a60-fe8e28f2488c' }.first
  end

  def test_organization_has_a_classification
    classification = 'party'
    assert_equal classification, organization_one.classification
  end

  def test_organization_has_identifiers
    identifiers = [{ identifier: 'Q794028', scheme: 'wikidata' }]
    assert_equal identifiers, organization_one.identifiers
  end

  def test_organization_has_an_image
    image = 'https://upload.wikimedia.org/wikipedia/commons/0/0c/EKRE_logo.png'
    assert_equal image, organization_one.image
  end

  def test_organization_has_links
    links = [{ note: 'website', url: 'http://www.ekre.ee/' }]
    assert_equal links, organization_one.links
  end

  def test_organization_has_a_name
    name = 'Eesti Konservatiivse Rahvaerakonna fraktsioon'
    assert_equal name, organization_one.name
  end

  def test_organization_has_other_names
    other_name = { lang: 'se', name: 'Estlándda Konservatiiva Álbmotbellodat', note: 'multilingual' }
    assert_equal 29, organization_one.other_names.count
    assert_includes organization_one.other_names, other_name
  end

  def test_organizatioins_has_seats
    assert_equal 101, organization_two.seats
  end

  def test_organization_should_return_an_empty_array_for_any_data_not_defined
    assert_equal [], organization_one.seats
    assert_equal [], organization_two.image
    assert_equal [], organization_two.links
    assert_equal [], organization_two.other_names
  end
end
