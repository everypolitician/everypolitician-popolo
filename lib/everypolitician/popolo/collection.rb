module Everypolitician
  module Popolo
    class Collection
      include Enumerable

      attr_reader :documents

      def initialize(json)
        documents = json.popolo[popolo_key]
        @documents = documents ? documents.map { |p| klass.new(p) } : []
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
        find_all do |object|
          attributes.all? { |k, v| object.send(k) == v }
        end
      end

      private

      def popolo_key
        raise "Collection subclasses must implement #popolo_key which returns " \
          "a symbol describing which top level Popolo key the collection's " \
          "documents live under."
      end

      # TODO: This feels pretty nasty, is there a better way of working out the
      # class name?
      def klass
        case self.class.to_s.split("::").last
        when "People"
          Person
        when "Organizations"
          Organization
        when "Memberships"
          Membership
        when "Events"
          Event
        when "Areas"
          Area
        else
          raise "Unknown class: #{self.class.to_s}"
        end
      end
    end
  end
end
