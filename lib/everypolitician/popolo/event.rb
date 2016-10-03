module Everypolitician
  module Popolo
    class Event < Entity
      def start_date
        document.fetch(:start_date, nil)
      end

      def end_date
        document.fetch(:end_date, nil)
      end

      def name
        document.fetch(:name, nil)
      end

      def classification
        document.fetch(:classification, nil)
      end

      def organization_id
        document.fetch(:organization_id, nil)
      end
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
