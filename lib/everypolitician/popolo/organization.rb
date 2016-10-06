module Everypolitician
  module Popolo
    class Organization < Entity
      def wikidata
        identifier('wikidata')
      end

      def classification
        document.fetch(:classification, nil)
      end

      def identifiers
        document.fetch(:identifiers, [])
      end

      def image
        document.fetch(:image, nil)
      end

      def links
        document.fetch(:links, [])
      end

      def name
        document.fetch(:name, nil)
      end

      def other_names
        document.fetch(:other_names, [])
      end

      def seats
        document.fetch(:seats, nil)
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
