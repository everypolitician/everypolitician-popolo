require 'test_helper'

class PersonTestBehaviour
  def estonia_fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def people
    @ppl ||= Everypolitician::Popolo.read(estonia_fixture).persons
  end

  def taavi
    people.find_by(name: 'Taavi Rõivas')
  end

  def etti
    people.find_by(name: 'Etti Kagarov')
  end

  def test_people_class
    assert_instance_of Everypolitician::Popolo::People, people
  end

  def test_class
    assert_instance_of Everypolitician::Popolo::Person, people.first
  end

  def test_equality
    assert_equal taavi, taavi
    refute_equal taavi, etti
  end

  def test_persons_subtraction
    person1 = { id: '123', name: 'Alice' }
    person2 = { id: '456', name: 'Bob', gender: 'male' }
    all_people = Everypolitician::Popolo::People.new([person1, person2])
    just_person_1 = Everypolitician::Popolo::People.new([person1])
    assert_equal [Everypolitician::Popolo::Person.new(person2)], all_people - just_person_1
  end
end
