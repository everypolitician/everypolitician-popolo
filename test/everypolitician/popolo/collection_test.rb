require 'test_helper'

class CollectionTest < Minitest::Test
  def test_find_by_finding_a_person
    popolo = Everypolitician::Popolo::JSON.new(
      persons: [{ id: 'abc', name: 'Jane' }, { id: '123', name: 'Bob' }]
    )

    assert_equal popolo.persons.find_by(id: '123').id, '123'
    assert_equal popolo.persons.find_by(id: '123').name, 'Bob'
  end

  def test_find_by_finding_no_item
    popolo = Everypolitician::Popolo::JSON.new(
      persons: [{ id: 'abc', name: 'Jane' }, { id: '123', name: 'Bob' }]
    )

    assert_equal popolo.persons.find_by(id: 'blah'), nil
  end

  def test_find_by_finding_an_organization_by_multiple_attributes
    popolo = Everypolitician::Popolo::JSON.new(
      organizations: [{ id: 'foo_corp', name: 'Foo Corp' }, { id: 'bar_corp', name: 'Bar Corp' }]
    )

    assert_equal popolo.organizations.find_by(id: 'foo_corp', name: 'Foo Corp').id, 'foo_corp'
    assert_equal popolo.organizations.find_by(id: 'foo_corp', name: 'Foo Corp').name, 'Foo Corp'
  end

  def test_where_finding_multiple_parties
    popolo = Everypolitician::Popolo::JSON.new(
      organizations: [
        { id: 'representatives', name: "House o' Representin'", classification: 'legislature' },
        { id: 'tomato', name: 'Sunripe Tomato Party', classification: 'party' },
        { id: 'greens', name: 'The Greens', classification: 'party' },
      ]
    )

    assert_equal popolo.organizations.where(classification: 'party').count, 2
    assert_equal popolo.organizations.where(classification: 'party').first.name, 'Sunripe Tomato Party'
  end

  def test_where_finding_no_items
    popolo = Everypolitician::Popolo::JSON.new(
      organizations: [
        { id: 'representatives', name: "House o' Representin'", classification: 'legislature' },
        { id: 'tomato', name: 'Sunripe Tomato Party', classification: 'party' },
        { id: 'greens', name: 'The Greens', classification: 'party' },
      ]
    )

    assert_equal popolo.organizations.where(classification: 'business'), []
  end

  def test_where_finding_by_multiple_attributes
    popolo = Everypolitician::Popolo::JSON.new(
      organizations: [
        { id: 'representatives', name: "House o' Representin'", classification: 'legislature' },
        { id: 'tomato', name: 'Sunripe Tomato Party', classification: 'party' },
        { id: 'greens', name: 'The Greens', classification: 'party' },
      ]
    )

    assert_equal popolo.organizations.where(classification: 'party', name: 'The Greens').count, 1
    assert_equal popolo.organizations.where(classification: 'party', name: 'The Greens').first.id, 'greens'
  end

  def test_where_finding_on_memberships
    popolo = Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json')

    assert_equal popolo.memberships.where(person_id: '0259486a-0410-49f3-aef9-8b79c15741a7', legislative_period_id: 'term/13').count, 1
  end
end
