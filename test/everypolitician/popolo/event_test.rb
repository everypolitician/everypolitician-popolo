require 'test_helper'
class EventTest < Minitest::Test
  def popolo
    @popolo ||= Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json')
  end

  def events
    @events ||= popolo.events
  end

  def test_reading_popolo_events
    event = events.first
    assert_instance_of Everypolitician::Popolo::Events, events
    assert_kind_of Everypolitician::Popolo::Event, event
    assert_instance_of Everypolitician::Popolo::Election, event
  end

  def test_no_events_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.events.none?
  end

  def test_accessing_event_properties
    event = events.where(classification: 'legislative period').first
    assert_equal 'term/12', event.id
    assert_equal '12th Riigikogu', event.name
    assert_equal '2011-03-27', event.start_date
    assert_equal '2015-03-23', event.end_date
    assert_equal 'legislative period', event.classification
    assert_equal '1ba661a9-22ad-4d0f-8a60-fe8e28f2488c', event.organization_id
    assert_equal 'Q967549', event.wikidata
  end

  def test_accessing_legislative_periods
    terms = popolo.legislative_periods
    assert_equal 2, terms.count
    term = terms.first
    assert_instance_of Everypolitician::Popolo::LegislativePeriod, term
    assert_equal 'term/12', term.id
  end

  def test_accessing_elections
    elections = popolo.elections
    assert_equal 14, elections.count
    election = elections.first
    assert_instance_of Everypolitician::Popolo::Election, election
    assert_equal 'Q1891860', election.id
  end

  def test_falls_back_to_event_class
    popolo = Everypolitician::Popolo::JSON.new(events: [{ classification: 'referendum', id: '123', foo: 'Bar' }])
    assert_instance_of EveryPolitician::Popolo::Event, popolo.events.first
  end

  def test_term_memberships
    term = popolo.terms.first
    memberships = term.memberships
    assert_equal memberships.count, 165
    assert_instance_of EveryPolitician::Popolo::Membership, memberships.first
    assert_equal memberships.first.person_id, '0259486a-0410-49f3-aef9-8b79c15741a7'
  end
end
