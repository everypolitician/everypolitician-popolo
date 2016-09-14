require 'test_helper'
class EventTest < Minitest::Test
  def events
    Everypolitician::Popolo.read('test/fixtures/turkey-ep-popolo-v1.0.json').events
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
    event = events.first
    assert_equal 'term/1', event.id
    assert_equal '1st Parliament', event.name
    assert_equal '1920-04-23', event.start_date
    assert_equal '1923-08-11', event.end_date
    assert_equal 'legislative period', event.classification
    assert_equal '83911419-04ab-4add-a687-93a4e8845296', event.organization_id
  end
end
