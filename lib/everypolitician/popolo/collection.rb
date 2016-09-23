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
        index_attributes(attributes)
        attributes.keys.map { |k| @indexes[k.to_sym][attributes[k]] }.reduce(:&) || []
      end

      def index_attributes(attributes = {})
        @indexes ||= {}
        attributes.keys.each do |k|
          @indexes[k] ||= group_by(&:"#{k}")
        end
      end
    end
  end
end
