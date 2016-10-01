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

  def test_organizations_type
    assert_instance_of Everypolitician::Popolo::Organizations, orgs
  end

  def test_organization_type
    assert_instance_of Everypolitician::Popolo::Organization, orgs.first
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

  def test_equality
    assert_equal orgs.first, orgs.first
    refute_equal orgs.first, orgs.drop(1).first
  end
end
