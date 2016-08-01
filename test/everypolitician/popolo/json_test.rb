require 'test_helper'

class JsonTest < Minitest::Test
  def popolo_json
    @popolo_json ||= Everypolitician::Popolo::JSON.new(
      events: [
        { name: 'Election 1', classification: 'general election', start_date: '2014-01-01' },
        { name: 'Term 2', classification: 'legislative period', start_date: '2015-01-01' },
        { name: 'Term 1', classification: 'legislative period', start_date: '2010-01-01' },
      ]
    )
  end

  def test_legislative_periods_ignores_other_event_types
    assert_equal 2, popolo_json.legislative_periods.size
  end

  def test_current_legislative_period_returns_correct_term
    assert_equal 'Term 2', popolo_json.current_legislative_period.name
  end

  def test_that_terms_returns_the_same_as_legislative_periods
    assert_equal popolo_json.terms, popolo_json.legislative_periods
  end

  def test_current_term_returns_the_same_as_current_legislative_period
    assert_equal popolo_json.current_term, popolo_json.current_legislative_period
  end
end
