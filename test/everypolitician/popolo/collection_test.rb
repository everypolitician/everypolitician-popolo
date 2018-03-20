# frozen_string_literal: true

require 'test_helper'

class CollectionTest < Minitest::Test
  def fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def popolo
    @popolo ||= Everypolitician::Popolo.read(fixture)
  end

  def test_find_by_id
    assert_equal 'Taavi Rõivas', popolo.persons.find_by(id: '6b71eefc-413d-4db6-88f0-d7ff845ebaf1').name
  end

  def test_find_by_name
    assert_equal '6b71eefc-413d-4db6-88f0-d7ff845ebaf1', popolo.persons.find_by(name: 'Taavi Rõivas').id
  end

  def test_find_by_finding_no_item
    assert_nil popolo.persons.find_by(name: 'Raavi Tõivas')
  end

  def test_find_by_finding_an_organization_by_multiple_attributes
    assert_equal 'SDE', popolo.organizations.find_by(id: 'SDE', name: 'Sotsiaaldemokraatliku Erakonna fraktsioon').id
    assert_nil popolo.organizations.find_by(id: 'IRL', name: 'Sotsiaaldemokraatliku Erakonna fraktsioon')
  end

  def test_where_finding_multiple_parties
    assert_equal popolo.organizations.count, 8
    assert_equal popolo.organizations.where(classification: 'party').count, 7
    assert_instance_of Everypolitician::Popolo::Organizations, popolo.organizations.where(classification: 'party')
  end

  def test_where_finding_no_items
    assert_equal popolo.organizations.where(classification: 'business').count, 0
  end

  def test_where_finding_on_memberships
    mem = popolo.memberships.where(person_id: '0259486a-0410-49f3-aef9-8b79c15741a7', legislative_period_id: 'term/13')
    assert_instance_of Everypolitician::Popolo::Memberships, mem
    assert_equal popolo.memberships.where(person_id: '0259486a-0410-49f3-aef9-8b79c15741a7', legislative_period_id: 'term/13').count, 1
  end

  def test_where_finding_some_attributes_with_no_matches
    popolo = Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json')

    assert_equal popolo.organizations.where(classification: 'party', name: 'The Reds').empty?, true
    assert_equal popolo.organizations.where(classification: 'party', name: 'The Reds').count, 0
    assert_equal popolo.organizations.where(name: 'The Reds', classification: 'party').count, 0
  end
end
