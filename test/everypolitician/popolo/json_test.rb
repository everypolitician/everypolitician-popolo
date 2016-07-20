require 'test_helper'

class Everypolitician::Popolo::JsonTest < Minitest::Test
  def test_legislative_periods
    popolo_json = Everypolitician::Popolo::JSON.new(
      events: [
        { name: 'Term 2', classification: 'legislative period', start_date: '2015-01-01' },
        { name: 'Term 1', classification: 'legislative period', start_date: '2010-01-01' },
      ],
    )
    assert_equal 2, popolo_json.legislative_periods.size
    assert_equal 'Term 2', popolo_json.current_legislative_period.name
  end
end
