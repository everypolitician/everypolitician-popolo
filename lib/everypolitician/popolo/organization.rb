module Everypolitician
  module Popolo
    class Organization < Entity
      attr_writer :classification, :identifiers, :image, :links, :name

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
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
