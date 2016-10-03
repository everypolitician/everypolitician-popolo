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
        identifier('wikidata')
      end

      private

      attr_reader :document
    end

    class DynamicEventClassFinder
      def self.new(doc, *args)
        case doc[:classification]
        when 'general election'
          Election.new(doc, *args)
        when 'legislative period'
          LegislativePeriod.new(doc, *args)
        else
          Event.new(doc, *args)
        end
      end
    end

    class Events < Collection
      entity_class DynamicEventClassFinder

      def elections
        where(classification: 'general election').sort_by(&:start_date)
      end

      def legislative_periods
        where(classification: 'legislative period').sort_by(&:start_date)
      end
    end
  end
end
