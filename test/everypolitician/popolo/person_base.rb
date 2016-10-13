require 'test_helper'

class PersonTestBase < Minitest::Test
  def estonia_fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def pakistan_fixture
    'test/fixtures/pakistan-ep-popolo-v1.0.json'
  end

  def burundi_fixture
    'test/fixtures/burundi-ep-popolo-v1.0.json'
  end

  def zimbabwe_fixture
    'test/fixtures/zimbabwe-senate-ep-popolo-v1.0.json'
  end

  def people
    @ppl ||= Everypolitician::Popolo.read(estonia_fixture).persons
  end

  def pakistan_people
    @pakistan_ppl ||= Everypolitician::Popolo.read(pakistan_fixture).persons
  end

  def burundi_people
    @burundi_ppl ||= Everypolitician::Popolo.read(burundi_fixture).persons
  end

  def zimbabwe_people
    @zimbabwe_ppl ||= Everypolitician::Popolo.read(zimbabwe_fixture).persons
  end

  def aadu
    people.find_by(name: 'Aadu Must')
  end

  def taavi
    people.find_by(name: 'Taavi Rõivas')
  end

  def eiki
    people.find_by(name: 'Eiki Nestor')
  end

  def etti
    people.find_by(name: 'Etti Kagarov')
  end

  def aaisha
    pakistan_people.find_by(name: 'Aaisha Gulalai')
  end

  def ahishakiye
    burundi_people.find_by(name: 'AHISHAKIYE Gloriose')
  end

  def agnes
    zimbabwe_people.find_by(name: 'Agnes Sibanda')
  end
end
