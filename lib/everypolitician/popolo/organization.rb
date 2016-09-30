module Everypolitician
  module Popolo
    class Organization < Entity
      attr_writer :classification, :identifiers, :image, :links, :name, :other_names, :seats

      def wikidata
        identifier('wikidata')
      end

      def classification
        document.fetch(:classification, [])
      end

      def identifiers
        document.fetch(:identifiers, [])
      end

      def image
        document.fetch(:image, [])
      end

      def links
        document.fetch(:links, [])
      end

      def name
        document.fetch(:name, [])
      end

      def other_names
        document.fetch(:other_names, [])
      end

      def seats
        document.fetch(:seats, [])
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
