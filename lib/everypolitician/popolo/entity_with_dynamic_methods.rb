module Everypolitician
  module Popolo
    class EntityWithDynamicMethods < Entity
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
    end
  end
end
