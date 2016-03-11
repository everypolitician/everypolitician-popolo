module Everypolitician
  module Popolo
    class Collection
      include Enumerable

      attr_reader :documents

      def each(&block)
        documents.each(&block)
      end

      def -(other)
        other_ids = Set.new(other.documents.map(&:id))
        documents.reject { |d| other_ids.include?(d.id) }
      end
    end
  end
end
