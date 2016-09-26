require 'test_helper'

class LegislativePeriodTest < Minitest::Test
  def popolo_wales
    Everypolitician::Popolo.read('test/fixtures/welsh-assembly-ep-popolo-v1.0.json')
  end

  def test_event_people_returns_array_of_person_objectsification
    term = popolo_wales.current_legislative_period
    assert_instance_of Everypolitician::Popolo::Person, term.people.first
  end

  def test_event_organizations
    term = popolo_wales.current_legislative_period
    assert_instance_of Everypolitician::Popolo::Organization, term.organizations.first
  end
end
