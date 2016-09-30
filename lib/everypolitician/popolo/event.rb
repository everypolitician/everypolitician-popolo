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

      def self.event_classes
        @classes ||= ObjectSpace.each_object(Class).select { |klass| klass < self }
      end

      def self.matches_classification(classification)
        classification == event_classification
      end

      private_class_method

      def self.event_classification(classification = nil)
        @event_classification ||= classification
      end

      private

      attr_reader :document
    end

    class Events < Collection
      entity_class Event

      def initialize(documents, popolo = nil)
        @event_class = {}
        @documents = documents ? documents.map { |p| class_for_event(p[:classification]).new(p, popolo) } : []
        @popolo = popolo
        @indexes = {}
      end

      def class_for_event(classification)
        @event_class[classification] ||= Event.event_classes.select { |e| e.matches_classification(classification) }.first || Event
      end
    end
  end
end
