module Everypolitician
  module Popolo
    class Area < Entity
      def identifiers
        document.fetch(:identifiers, [])
      end

      def name
        document.fetch(:name, nil)
      end

      def other_names
        document.fetch(:other_names, [])
      end

      def type
        document.fetch(:type, nil)
      end

      def wikidata
        identifier('wikidata')
      end
    end

    class Areas < Collection
      entity_class Area
    end
  end
end
