require 'test_helper'

class EventTest < Minitest::Test
  def test_reading_popolo_events
    popolo = Everypolitician::Popolo::JSON.new(
      events: [{ id: 'term/8', name: '8th Verkhovna Rada', start_date: '2014-11-27' }]
    )
    event = popolo.events.first

    assert_instance_of Everypolitician::Popolo::Events, popolo.events
    assert_instance_of Everypolitician::Popolo::Event, event
  end

  def test_no_events_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.events.none?
  end

  def test_accessing_event_properties
    popolo = Everypolitician::Popolo::JSON.new(
      events: [{ id:              'term/8',
                 start_date:      '2014-11-27',
                 classification:  'legislative period',
                 name:            '8th Verkhovna Rada',
                 organization_id: '2fd16480-aa16-4055-bcad-66bfaae6f18b',
                 wikidata:        'Q123456', },]
    )
    event = popolo.events.first

    assert_equal 'term/8', event.id
    assert_equal '8th Verkhovna Rada', event.name
    assert_equal '2014-11-27', event.start_date
    assert_nil event.end_date
    assert_equal 'legislative period', event.classification
    assert_equal '2fd16480-aa16-4055-bcad-66bfaae6f18b', event.organization_id
    assert_equal 'Q123456', event.wikidata
  end
end
