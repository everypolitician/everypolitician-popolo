module Everypolitician
  module Popolo
    class Organization < Entity
      def initializer(document)
        @document = document
      end

      def classification
        document[:classification]
      end

      def identifiers
        document[:identifiers]
      end

      def image
        document[:image]
      end

      def links
        document[:links]
      end

      def name
        document[:name]
      end

      def other_names
        document[:other_names]
      end

      def seats
        document[:seats]
      end

      def wikidata
        identifier('wikidata')
      end

      private

      attr_reader :document

      def identifier(scheme_name)
        identifiers.find { |i| i[:scheme] == scheme_name }[:identifier] rescue nil
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
