require 'test_helper'

class PostTest < Minitest::Test
  def fixture
    'test/fixtures/kenya-ep-popolo-v1.0.json'
  end

  def posts
    @posts ||= Everypolitician::Popolo.read(fixture).posts
  end

  def rep
    posts.find_by(id: 'nominated_representative')
  end

  def test_object_types
    assert_instance_of Everypolitician::Popolo::Posts, posts
    assert_instance_of Everypolitician::Popolo::Post, rep
  end

  def test_no_posts_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.posts.none?
  end

  def test_id
    assert_equal 'nominated_representative', rep.id
  end

  def test_label
    assert_equal 'Nominated Representative', rep.label
  end

  def test_organization_id
    assert_equal '574eff8e-8171-4f2b-8279-60ed8dec1a2a', rep.organization_id
  end

  def test_organization
    assert_equal 'National Assembly', rep.organization.name
  end

  def test_it_returns_nil_for_missing_label
    popolo = Everypolitician::Popolo::JSON.new(
      posts: [{ id: 'womens_representative' }]
    )
    post = popolo.posts.first

    assert_nil post.label
  end
end
