require 'test_helper'
class EventTest < Minitest::Test
  def events
    @events ||= Everypolitician::Popolo.read('test/fixtures/estonia-ep-popolo-v1.0.json').events
  end

  def test_reading_popolo_events
    event = events.first
    assert_instance_of Everypolitician::Popolo::Events, events
    assert_instance_of Everypolitician::Popolo::Event, event
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
    # TODO: assert_equal 'Q967549', event.wikidata
  end
end
