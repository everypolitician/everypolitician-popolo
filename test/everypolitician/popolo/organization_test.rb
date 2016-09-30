require 'test_helper'

class OrganizationTest < Minitest::Test
  def organizations
    @organizations ||= Everypolitician::Popolo.read('test/fixtures/turkey-ep-popolo-v1.0.json').organizations
  end

  def organization
    @organization ||= organizations.select { |o| o.id == 'MHP' }.first
  end

  def organization_with_seats
    @organization_with_seats ||= organizations.select { |o| o.classification == 'legislature' }.first
  end

  def test_reading_popolo_organizationsions
    assert_instance_of Everypolitician::Popolo::Organizations, organizations
    assert_instance_of Everypolitician::Popolo::Organization, organization
  end

  def test_no_organizations_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.organizations.none?
  end

  def test_organization_id
    assert_equal 'MHP', organization.id
  end

  def test_organization_name
    assert_equal 'Milliyetçi Hareket Partisi', organization.name
  end

  def test_organization_classification
    assert_equal 'party', organization.classification
  end

  def test_organization_image
    assert_equal 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Milliyetçi_Hareket_Partisi_amblemi.png', organization.image
  end

  def test_organization_links
    assert_equal [{ note: 'website', url: 'http://www.mhp.org.tr/' }], organization.links
  end

  def test_organization_other_names
    organization_other_names = { lang: 'bar', name: 'Pårtei då Nationalistischn Bwegung', note: 'multilingual' }
    assert_equal organization_other_names, organization.other_names.first
  end

  def test_organization_identifiers
    assert_equal [{ identifier: 'Q251077', scheme: 'wikidata' }], organization.identifiers
  end

  def test_organization_seats
    assert_equal 550, organization_with_seats.seats
  end

  def test_organization_equality_based_on_id
    org1 = Everypolitician::Popolo::Organization.new(id: 'abc', name: 'ACME')
    org2 = Everypolitician::Popolo::Organization.new(id: 'abc', name: 'ACME')
    assert_equal org1, org2
  end

  def test_organizations_subtraction
    org1 = { id: 'abc', name: 'ACME' }
    org2 = { id: 'def', name: 'TNT INC' }
    all_orgs = Everypolitician::Popolo::Organizations.new([org1, org2])
    just_org_1 = Everypolitician::Popolo::Organizations.new([org1])
    assert_equal [Everypolitician::Popolo::Organization.new(org2)], all_orgs - just_org_1
  end

  def test_organization_wikidata
    assert_equal 'Q348125', organizations.first.wikidata
  end

  def test_organization_no_wikidata
    org = Everypolitician::Popolo::Organization.new(
      id:   'abc',
      name: 'ACME'
    )
    assert_nil org.wikidata
  end
end
