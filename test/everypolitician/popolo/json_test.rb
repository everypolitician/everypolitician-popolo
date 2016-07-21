require 'test_helper'

class Everypolitician::Popolo::JsonTest < Minitest::Test
  def popolo_json
    @popolo_json ||= Everypolitician::Popolo::JSON.new(
      events: [
        { name: 'Election 1', classification: 'general election', start_date: '2014-01-01' },
        { name: 'Term 2', classification: 'legislative period', start_date: '2015-01-01' },
        { name: 'Term 1', classification: 'legislative period', start_date: '2010-01-01' },
      ],
    )
  end

  def test_legislative_periods_ignores_other_event_types
    assert_equal 2, popolo_json.legislative_periods.size
    assert_equal 2, popolo_json.terms.size
  end

  def test_current_legislative_period_returns_correct_term
    assert_equal 'Term 2', popolo_json.current_legislative_period.name
    assert_equal 'Term 2', popolo_json.current_term.name
  end
end
