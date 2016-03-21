require 'active_support/core_ext'
require 'pry'

module Everypolitician
  module Popolo
    class Entity

      class_attribute :attributes
      self.attributes = %i(:id)

      attr_reader :document

      def initialize(document)
        @document = document

        attributes.each do |name|
          define_singleton_method(name.to_s) { @document[name] }
        end

        document.reject { |k,_| self.class.attributes.include? k }.each do |key, value|
          define_singleton_method(key) { value }
        end
      end
      
      def [](key)
        document[key]
      end

      def key?(key)
        document.key?(key)
      end

      def ==(other)
        id == other.id
      end
      alias eql? ==

    end
  end
end
