require 'test_helper'

class OrganizationTest < Minitest::Test
  def test_popolo
    Everypolitician::Popolo::JSON.new(organizations: [{ id:             '123',
                                                        name:           'ACME',
                                                        classification: 'party',
                                                        identifier:     'Q288523',
                                                        image:          'http://www.parlamentra.org/upload/iblock/09f/avidzba-f.jpg',
                                                        links:          [{ url: 'http://www.test.com' }],
                                                        other_names:    [{ name: 'ACME Inc' }],
                                                        identifiers:    [{ identifier: 'Q288523', scheme: 'wikidata' }],
                                                        seats:          42, },])
  end

  def test_reading_popolo_organizations
    popolo = Everypolitician::Popolo::JSON.new(organizations: [{ id: '123', name: 'ACME' }])
    assert_instance_of Everypolitician::Popolo::Organizations, popolo.organizations
    organization = popolo.organizations.first
    assert_instance_of Everypolitician::Popolo::Organization, organization
  end

  def test_no_organizations_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.organizations.none?
  end

  def test_accessing_organization_properties
    organization = test_popolo.organizations.first
    assert_equal '123', organization.id
    assert_equal 'ACME', organization.name
    assert_equal 'party', organization.classification
    assert_equal 'http://www.parlamentra.org/upload/iblock/09f/avidzba-f.jpg', organization.image
    assert_equal [{ url: 'http://www.test.com' }], organization.links
    assert_equal [{ name: 'ACME Inc' }], organization.other_names
    assert_equal [{ identifier: 'Q288523', scheme: 'wikidata' }], organization.identifiers
    assert_equal 42, organization.seats
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
    org = Everypolitician::Popolo::Organization.new(
      id:          'abc',
      name:        'ACME',
      identifiers: [{ identifier: 'Q288523', scheme: 'wikidata' }]
    )
    assert_equal 'Q288523', org.wikidata
  end

  def test_organization_no_wikidata
    org = Everypolitician::Popolo::Organization.new(
      id:   'abc',
      name: 'ACME'
    )
    assert_nil org.wikidata
  end
end
