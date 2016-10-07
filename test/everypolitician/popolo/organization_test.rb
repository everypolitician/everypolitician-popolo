require 'test_helper'

class OrganizationTest < Minitest::Test
  def fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def orgs
    @orgs ||= Everypolitician::Popolo.read(fixture).organizations
  end

  def irl
    orgs.find_by(id: 'IRL')
  end

  def ekre
    orgs.find_by(id: 'EKRE')
  end

  def eva
    orgs.find_by(id: 'EVA')
  end

  def riigikogu
    orgs.find_by(id: '1ba661a9-22ad-4d0f-8a60-fe8e28f2488c')
  end

  def test_organizations_type
    assert_instance_of Everypolitician::Popolo::Organizations, orgs
  end

  def test_organization_type
    assert_instance_of Everypolitician::Popolo::Organization, orgs.first
  end

  def test_classification
    assert_equal 'party', irl.classification
  end

  def test_name
    assert_equal 'Isamaa ja Res Publica Liidu fraktsioon', irl.name
  end

  def test_wikidata
    assert_equal 'Q163347', irl.wikidata
  end

  def test_website
    assert_equal 'http://www.irl.ee/', irl.links.first[:url]
  end

  def test_image
    assert_equal 'https://upload.wikimedia.org/wikipedia/commons/0/0c/EKRE_logo.png', ekre.image
  end

  def test_links
    link = { note: 'website', url: 'http://www.ekre.ee/' }
    assert_equal [], eva.links
    assert_equal 1, ekre.links.count
    assert_includes ekre.links, link
  end

  def test_organization_has_other_names
    other_name = { lang: 'en', name: 'Pro Patria and Res Publica Union', note: 'multilingual' }
    assert_equal 23, irl.other_names.count
    assert_includes irl.other_names, other_name
  end

  def test_seats
    assert_equal nil, irl.seats
    assert_equal 101, riigikogu.seats
  end

  def test_equality
    assert_equal orgs.first, orgs.first
    refute_equal orgs.first, orgs.drop(1).first
  end
end
