module Everypolitician
  module Popolo
    class Collection
      include Enumerable

      # @return [Array] the items in this collection
      attr_reader :documents

      def initialize(documents)
        @documents = documents ? documents.map { |p| klass.new(p) } : []
      end

      def each(&block)
        documents.each(&block)
      end

      # Subtract items in another Collection from this based on the same *id* attribute
      #
      # @param other [Collection] items to subtract
      # @return Collection with `other` removed
      def -(other)
        other_ids = Set.new(other.documents.map(&:id))
        documents.reject { |d| other_ids.include?(d.id) }
      end

      # Select the first item with attributes matching the specified criteria.
      #
      # @param attributes [Hash] of attributes expected item must have
      # @return The first item that matches the specified attrubutes in this collection
      def find_by(attributes = {})
        where(attributes).first
      end

      # Select all items with attributes matching the specified criteria.
      #
      # @param attributes [Hash] of attributes
      # @return A subset of this collection with all items that match the specified criteria
      def where(attributes = {})
        find_all do |object|
          attributes.all? { |k, v| object.send(k) == v }
        end
      end

      private

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
