require 'test_helper'

class AreaTest < Minitest::Test
  def fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def areas
    @areas ||= Everypolitician::Popolo.read(fixture).areas
  end

  def tartu
    areas.find_by(name: 'Tartu linn')
  end

  def ida
    areas.find_by(name: 'Ida-Virumaa')
  end

  def test_areas_class
    assert_instance_of Everypolitician::Popolo::Areas, areas
  end

  def test_area_class
    assert_instance_of Everypolitician::Popolo::Area, areas.first
  end

  def test_id
    assert_equal 'area/tartu_linn', tartu.id
  end

  def test_name
    assert_equal 'Tartu linn', tartu.name
  end

  def test_type
    assert_equal nil, ida.type
    assert_equal 'constituency', tartu.type
  end

  def test_other_names
    other_name = { lang: 'fr', name: "Dixième circonscription législative d'Estonie", note: 'multilingual' }
    assert_equal [], ida.other_names
    assert_equal 3, tartu.other_names.count
    assert_includes tartu.other_names, other_name
  end

  def test_identifiers
    identifier = { identifier: 'Q3032626', scheme: 'wikidata' }
    assert_equal [], ida.identifiers
    assert_equal 1, tartu.identifiers.count
    assert_includes tartu.identifiers, identifier
  end

  def test_wikidata
    assert_equal 'Q3032626', tartu.wikidata
  end
end
