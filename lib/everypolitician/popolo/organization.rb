module Everypolitician
  module Popolo
    class Organization < Entity
      attr_writer :classification

      def wikidata
        identifier('wikidata')
      end

      def classification
        document.fetch(:classification, [])
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
