require 'test_helper'

class MembershipTest < Minitest::Test
  def fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def memberships
    @mems ||= Everypolitician::Popolo.read(fixture).memberships
  end

  def test_memberships_class
    assert_instance_of Everypolitician::Popolo::Memberships, memberships
  end

  def test_membership_class
    assert_instance_of Everypolitician::Popolo::Membership, memberships.first
  end

  def test_membership_with_start_date
    with_start_date = memberships.partition(&:start_date).first
    assert_equal '2015-04-09', with_start_date.first.start_date
  end

  def test_membership_with_no_start_date
    with_no_start_date = memberships.partition(&:start_date).last
    assert_equal nil, with_no_start_date.first.start_date
  end

  def test_membership_with_end_date
    with_end_date = memberships.partition(&:end_date).first
    assert_equal '2015-04-08', with_end_date.first.end_date
  end

  def test_membership_with_no_end_date
    with_no_end_date = memberships.partition(&:end_date).last
    assert_equal nil, with_no_end_date.first.end_date
  end

  def test_membership_person
    assert_equal 'Kalle Muuli', memberships.first.person.name
  end

  def test_membership_equality
    assert_equal memberships.first, memberships.first
  end

  def test_membership_on_behalf_of_id
    assert_equal 'IRL', memberships.first.on_behalf_of_id
  end

  def test_membership_area_id
    assert_equal 'area/tartu_linn', memberships.first.area_id
  end

  def test_membership_role
    assert_equal 'member', memberships.first.role
  end

  def test_membership_organization_id
    assert_equal '1ba661a9-22ad-4d0f-8a60-fe8e28f2488c', memberships.first.organization_id
  end

  def test_membership_organization
    assert_equal 'Riigikogu', memberships.first.organization.name
  end

  def test_membership_on_behalf_of
    assert_equal 'Isamaa ja Res Publica Liidu fraktsioon', memberships.first.on_behalf_of.name
  end

  def test_membership_inequality
    refute_equal memberships.first, memberships.drop(1).first
  end
end
