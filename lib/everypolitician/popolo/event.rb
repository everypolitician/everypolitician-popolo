module Everypolitician
  module Popolo
    class Event < Entity
      def initialize(document, _p)
        @document = document
      end

      def start_date
        document[:start_date]
      end

      def end_date
        document[:end_date]
      end

      def id
        document[:id]
      end

      def name
        document[:name]
      end

      def classification
        document[:classification]
      end

      def organization_id
        document[:organization_id]
      end

      def wikidata
        document[:wikidata]
      end

      private

      attr_reader :document
    end

    class Events < Collection
      entity_class Event
    end
  end
end
