module Everypolitician
  module Popolo
    class Collection
      include Enumerable

      attr_reader :documents
      attr_reader :popolo

      # set the class that represents individual items in the
      # collection
      def self.entity_class(entity = nil)
        @entity_class ||= entity
      end

      def initialize(documents, popolo = nil)
        @entity_class = {}
        @documents = documents ? documents.map { |p| class_for_entity(p).new(p, popolo) } : []
        @popolo = popolo
        @indexes = {}
        @of_class = {}
      end

      def each(&block)
        documents.each(&block)
      end

      def -(other)
        other_ids = Set.new(other.documents.map(&:id))
        documents.reject { |d| other_ids.include?(d.id) }
      end

      def find_by(attributes = {})
        where(attributes).first
      end

      def where(attributes = {})
        new_collection(attributes.map { |k, v| index_for(k.to_sym)[v].to_a }.reduce(:&))
      end

      def empty?
        count.zero?
      end

      def of_class(klass, collection = self)
        @of_class[klass] ||= new_collection(select { |e| e.class == klass }, collection)
      end

      private

      def index_for(attr)
        @indexes[attr] ||= group_by(&attr)
      end

      def new_collection(entities, klass = self.class)
        klass.new(entities.to_a.map(&:document), popolo)
      end

      def class_for_entity(_document)
        self.class.entity_class
      end
    end
  end
end
