module Everypolitician
  module Popolo
    class Areas < Collection; end

    class Area
      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end
    end
  end
end
