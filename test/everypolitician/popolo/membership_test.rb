require 'test_helper'

class Everypolitician::MembershipTest < Minitest::Test
  def popolo
    @popolo ||= Everypolitician::Popolo::JSON.new(
      memberships: [
        {
          on_behalf_of_id: '456',
          organization_id: 'legislature',
          person_id:       '123',
          role:            'member',
        },
      ],
      persons:     [
        {
          id:   '123',
          name: 'Bob',
        },
      ]
    )
  end

  def test_reading_popolo_memberships
    membership = popolo.memberships.first

    assert_instance_of Everypolitician::Popolo::Memberships, popolo.memberships
    assert_instance_of Everypolitician::Popolo::Membership, membership
  end

  def test_no_memberships_in_popolo_data
    popolo_no_memberships = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo_no_memberships.memberships.none?
  end

  def test_membership_start_date_method_always_present
    member_with_no_start_date = Everypolitician::Popolo::Membership.new({})
    member_with_start_date = Everypolitician::Popolo::Membership.new(start_date: '2016-01-01')

    assert_equal member_with_no_start_date.start_date, nil
    assert_equal member_with_start_date.start_date, '2016-01-01'
  end

  def test_membership_end_date_method_always_present
    member_with_no_end_date = Everypolitician::Popolo::Membership.new({})
    member_with_end_date = Everypolitician::Popolo::Membership.new(end_date: '2016-12-31')

    assert_equal member_with_no_end_date.end_date, nil
    assert_equal member_with_end_date.end_date, '2016-12-31'
  end

  def test_membership_person
    assert_equal 'Bob', popolo.memberships.first.person.name
  end
end
