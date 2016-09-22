module Everypolitician
  module Popolo
    class Collection
      include Enumerable

      attr_reader :documents
      attr_reader :popolo

      # set the class that represents individual items in the
      # collection
      def self.entity_class(entity)
        @entity_class = entity
      end

      # we need to do this slightly awful looking thing becuase
      # we want a class instance variable and not an instance
      # variable
      def entity_class
        self.class.instance_variable_get :@entity_class
      end

      def initialize(documents, popolo = nil)
        @documents = documents ? documents.map { |p| entity_class.new(p, popolo) } : []
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
        select do |object|
          attributes.all? { |k, v| object.send(k) == v }
        end
      end
    end
  end
end
