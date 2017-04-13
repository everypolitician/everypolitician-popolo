module Everypolitician
  module Popolo
    class Entity
      attr_reader :document
      attr_reader :popolo

      def self.classification(classification = nil)
        @classification ||= classification
      end

      def self.inherited(subclass)
        @subclasses ||= []
        @subclasses.push(subclass)
      end

      def self.subclasses
        @subclasses || []
      end

      def initialize(document, popolo = nil)
        @document = document
        @popolo = popolo
      end

      def id
        document.fetch(:id, nil)
      end

      def id
        document.fetch(:id, nil)
      end

      def [](key)
        document[key]
      end

      def key?(key)
        document.key?(key)
      end

      def ==(other)
        self.class == other.class && id == other.id
      end
      alias eql? ==

      def identifiers
        document.fetch(:identifiers, [])
      end

      def identifier(scheme)
        identifiers.find(-> { {} }) { |i| i[:scheme] == scheme }[:identifier]
      end

      def wikidata
        identifier('wikidata')
      end
    end
  end
end
