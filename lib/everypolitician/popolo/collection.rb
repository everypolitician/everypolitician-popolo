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
        @documents = documents ? documents.map { |p| self.class.entity_class.new(p, popolo) } : []
        @popolo = popolo
        @indexes = {}
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
        attributes.map { |k, v| index_for(k.to_sym)[v].to_a }.reduce(:&) || []
      end

      private

      def index_for(attr)
        @indexes[attr] ||= group_by(&attr)
      end
    end
  end
end
