require 'test_helper'

class Everypolitician::AreaTest < Minitest::Test
  def test_reading_popolo_areas
    popolo = Everypolitician::Popolo::JSON.new(
      areas: [{ id: '123', name: 'Newtown', type: 'constituency' }]
    )
    area = popolo.areas.first

    assert_instance_of Everypolitician::Popolo::Areas, popolo.areas
    assert_instance_of Everypolitician::Popolo::Area, area
  end
end
