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

    class Events < Collection
      entity_class Event

      def elections
        of_class(Election)
      end

      def legislative_periods
        of_class(LegislativePeriod)
      end

      def class_for_entity(document)
        @event_class[document[:classification]] ||= self.class.entity_class.subclasses.find do |e|
          e.classification == document[:classification]
        end || self.class.entity_class
      end
    end
  end
end
