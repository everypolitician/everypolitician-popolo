require 'test_helper'

class AreaTest < Minitest::Test
  def estonia_fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def turkey_fixture
    'test/fixtures/turkey-ep-popolo-v1.0.json'
  end

  def estonia_areas
    @estonia_areas ||= Everypolitician::Popolo.read(estonia_fixture).areas
  end

  def turkey_areas
    @turkey_areas ||= Everypolitician::Popolo.read(turkey_fixture).areas
  end

  def tartu
    estonia_areas.find_by(name: 'Tartu linn')
  end

  def adana
    @adana ||= turkey_areas.find_by(id: 'area/adana')
  end

  def test_areas_class
    assert_instance_of Everypolitician::Popolo::Areas, estonia_areas
  end

  def test_area_class
    assert_instance_of Everypolitician::Popolo::Area, estonia_areas.first
  end

  def test_id
    assert_equal 'area/tartu_linn', tartu.id
  end

  def test_name
    assert_equal 'Tartu linn', tartu.name
  end

  def test_type
    # we don't have any data that has a missing area type so generate one
    area = Everypolitician::Popolo::Area.new(id: 'an_area', name: 'An Area')
    assert_nil area.type
    assert_equal 'constituency', tartu.type
  end

  def test_other_names
    other_name = { lang: 'fr', name: "Dixième circonscription législative d'Estonie", note: 'multilingual' }
    assert_equal [], adana.other_names
    assert_equal 3, tartu.other_names.count
    assert_includes tartu.other_names, other_name
  end

  def test_identifiers
    identifier = { identifier: 'Q3032626', scheme: 'wikidata' }
    assert_equal [], adana.identifiers
    assert_equal 1, tartu.identifiers.count
    assert_includes tartu.identifiers, identifier
  end

  def test_wikidata
    assert_nil adana.wikidata
    assert_equal 'Q3032626', tartu.wikidata
  end
end
