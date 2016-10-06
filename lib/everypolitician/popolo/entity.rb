module Everypolitician
  module Popolo
    class Entity
      attr_accessor :id
      attr_reader :document
      attr_reader :popolo

      def initialize(document, popolo = nil)
        @document = document
        @popolo = popolo
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
    end
  end
end
