require 'test_helper'

class PostTest < Minitest::Test
  def fixture
    'test/fixtures/estonia-ep-popolo-v1.0.json'
  end

  def posts
    @posts ||= Everypolitician::Popolo.read(fixture).posts
  end

  def mp
    posts.find_by(id: 'member-of-parliament')
  end

  def test_object_types
    assert_instance_of Everypolitician::Popolo::Posts, posts
    assert_instance_of Everypolitician::Popolo::Post, mp
  end

  def test_no_posts_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.posts.none?
  end

  def test_id
    assert_equal 'member-of-parliament', mp.id
  end

  def test_label
    assert_equal 'Member of Parliament', mp.label
  end

  def test_organization_id
    assert_equal '1ba661a9-22ad-4d0f-8a60-fe8e28f2488c', mp.organization_id
  end

  def test_it_returns_nil_for_missing_label
    popolo = Everypolitician::Popolo::JSON.new(
      posts: [{ id: 'womens_representative' }]
    )
    post = popolo.posts.first

    assert_nil post.label
  end
end
