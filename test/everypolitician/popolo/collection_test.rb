require "test_helper"

class Everypolitician::CollectionTest < Minitest::Test
  def test_find_by_finding_a_person
    popolo = Everypolitician::Popolo::JSON.new(
      persons: [{ id: "abc", name: "Jane" }, { id: "123", name: "Bob" }]
    )

    assert_equal popolo.persons.find_by(id: "123").id, "123"
    assert_equal popolo.persons.find_by(id: "123").name, "Bob"
  end

  def test_find_by_finding_no_item
    popolo = Everypolitician::Popolo::JSON.new(
      persons: [{ id: "abc", name: "Jane" }, { id: "123", name: "Bob" }]
    )

    assert_equal popolo.persons.find_by(id: "blah"), nil
  end

  def test_find_by_finding_an_organization_by_multiple_attributes
    popolo = Everypolitician::Popolo::JSON.new(
      organizations: [{ id: "foo_corp", name: "Foo Corp" }, { id: "bar_corp", name: "Bar Corp" }]
    )

    assert_equal popolo.organizations.find_by(id: "foo_corp", name: "Foo Corp").id, "foo_corp"
    assert_equal popolo.organizations.find_by(id: "foo_corp", name: "Foo Corp").name, "Foo Corp"
  end
end
