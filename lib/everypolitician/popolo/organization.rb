module Everypolitician
  module Popolo
    class Organization < Entity
      attr_writer :classification, :identifiers, :image

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
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
