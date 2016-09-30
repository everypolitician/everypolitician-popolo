module Everypolitician
  module Popolo
    class Organization < Entity
      attr_writer :classification, :identifiers

      def wikidata
        identifier('wikidata')
      end

      def classification
        document.fetch(:classification, [])
      end

      def identifiers
        document.fetch(:identifiers, [])
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
