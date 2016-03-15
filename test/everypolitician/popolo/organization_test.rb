require 'test_helper'

class Everypolitician::OrganizationTest < Minitest::Test
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
    popolo = Everypolitician::Popolo::JSON.new(organizations: [{ id: '123', name: 'ACME' }])
    organization = popolo.organizations.first
    assert_equal '123', organization.id
    assert_equal 'ACME', organization.name
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
end
