module Everypolitician
  module Popolo
    class Post < Entity
      def label
        document.fetch(:label, nil)
      end

      def organization_id
        document.fetch(:organization_id, nil)
      end

      def organization
        popolo.organizations.find_by(id: organization_id)
      end
    end
    class Posts < Collection
      entity_class Post
    end
  end
end
