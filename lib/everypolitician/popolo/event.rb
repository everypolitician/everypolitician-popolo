module Everypolitician
  module Popolo
    class Event < DynamicEntity
      subclasses [Election, LegislativePeriod]
      default_class Event

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

    class Events < Collection
      entity_class Event

      def elections
        where(classification: 'general election').sort_by(&:start_date)
      end

      def legislative_periods
        where(classification: 'legislative period').sort_by(&:start_date)
      end
    end
  end
end
