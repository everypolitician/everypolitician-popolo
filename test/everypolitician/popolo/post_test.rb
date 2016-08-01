require 'test_helper'

class PostTest < Minitest::Test
  def test_reading_popolo_posts
    popolo = Everypolitician::Popolo::JSON.new(
      posts: [{ id: 'womens_representative', label: "Women's Representative" }]
    )
    post = popolo.posts.first

    assert_instance_of Everypolitician::Popolo::Posts, popolo.posts
    assert_instance_of Everypolitician::Popolo::Post, post
  end

  def test_no_posts_in_popolo_data
    popolo = Everypolitician::Popolo::JSON.new(other_data: [{ id: '123', foo: 'Bar' }])
    assert_equal true, popolo.posts.none?
  end

  def test_accessing_post_properties
    popolo = Everypolitician::Popolo::JSON.new(
      posts: [{ id: 'womens_representative', label: "Women's Representative" }]
    )
    post = popolo.posts.first

    assert_equal 'womens_representative', post.id
    assert_equal "Women's Representative", post.label
  end

  def test_it_returns_nil_for_missing_label
    popolo = Everypolitician::Popolo::JSON.new(
      posts: [{ id: 'womens_representative' }]
    )
    post = popolo.posts.first

    assert_nil post.label
  end
end
