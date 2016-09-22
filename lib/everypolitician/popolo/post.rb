module Everypolitician
  module Popolo
    class Posts < Collection
    end

    class Post < Entity
      attr_reader :label
    end
  end
end
