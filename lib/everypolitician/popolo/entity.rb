require 'pry'

module Everypolitician
  module Popolo
    class Entity

      attr_accessor :id
      attr_reader :document

      def initialize(document)
        @document = document

        document.each do |key, value|
          if respond_to?("#{key}=")
            __send__("#{key}=", value)
          else
            define_singleton_method(key) { value }
          end
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
