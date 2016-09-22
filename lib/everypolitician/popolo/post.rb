module Everypolitician
  module Popolo
    class Post < Entity
      attr_reader :label
    end

    class Posts < Collection
    end
  end
end
