module Everypolitician
  module Popolo
    class Post < Entity
      attr_reader :label
    end

    class Posts < Collection
      entity_class Post
    end
  end
end
