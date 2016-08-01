require 'test_helper'

class AreaTest < Minitest::Test
  def test_reading_popolo_areas
    popolo = Everypolitician::Popolo::JSON.new(
      areas: [{ id: '123', name: 'Newtown', type: 'constituency' }]
    )
    area = popolo.areas.first

    assert_instance_of Everypolitician::Popolo::Areas, popolo.areas
    assert_instance_of Everypolitician::Popolo::Area, area
  end

  def test_no_areas_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.areas.none?
  end

  def test_accessing_area_properties
    popolo = Everypolitician::Popolo::JSON.new(
      areas: [{ id: '123', name: 'Newtown', type: 'constituency' }]
    )
    area = popolo.areas.first

    assert_equal '123', area.id
    assert_equal 'Newtown', area.name
    assert_equal 'constituency', area.type
  end
end
