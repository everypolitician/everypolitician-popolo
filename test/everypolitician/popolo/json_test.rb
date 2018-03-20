# frozen_string_literal: true

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
    assert_equal 2, popolo_json.legislative_periods.count
  end

  def test_latest_legislative_period_returns_correct_term
    assert_equal 'Term 2', popolo_json.latest_legislative_period.name
  end

  def test_current_legislative_period_returns_correct_term
    assert_equal 'Term 2', popolo_json.current_legislative_period.name
  end

  def test_that_terms_returns_the_same_as_legislative_periods
    assert_equal popolo_json.terms, popolo_json.legislative_periods
  end

  def test_latest_term_returns_the_same_as_latest_legislative_period
    assert_equal popolo_json.latest_term, popolo_json.latest_legislative_period
  end

  def test_current_legislative_period_returns_the_same_as_latest_legislative_period
    assert_equal popolo_json.current_legislative_period, popolo_json.latest_legislative_period
  end

  def test_that_terms_returns_only_legislative_period_objects
    assert_equal popolo_json.terms.count, 2
    assert_instance_of Everypolitician::Popolo::LegislativePeriod, popolo_json.terms.first
    assert_instance_of Everypolitician::Popolo::LegislativePeriod, popolo_json.terms.to_a.last
  end
end
