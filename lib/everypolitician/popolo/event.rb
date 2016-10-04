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
      @subclasses = {}

      def self.new(doc, *args)
        find_class(doc[:classification]).new(doc, *args)
      end

      def self.subclasses
        [Election, LegislativePeriod]
      end

      def self.find_class(classification)
        @subclasses[classification] ||= subclasses.select { |s| s.classification == classification }.first || Event
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
