module Everypolitician
  module Popolo
    class Entity
      attr_reader :document
      attr_reader :popolo

      def self.classification(classification = nil)
        @classification ||= classification
      end

      def initialize(document, popolo = nil)
        @document = document
        @popolo = popolo

        document.each do |key, value|
          if respond_to?("#{key}=")
            __send__("#{key}=", value)
          else
            define_singleton_method(key) { value }
          end
        end
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

    class DynamicEntity < Entity
      def self.new(doc, *args)
        find_class(doc[:classification]).new(doc, *args)
      end

      def self.classification(classification = nil)
        @classification ||= classification
      end

      def self.subclasses(subclasses = [])
        @subclasses ||= subclasses
      end

      def self.default_class(default_class = nil)
        @default_class ||= default_class
      end

      def self.find_class(classification)
        @subclasses[classification] ||= subclasses.select { |s| s.classification == classification }.first || default_class
      end
    end
  end
end
