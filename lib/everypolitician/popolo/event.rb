module Everypolitician
  module Popolo
    class Events < Collection; end

    class Event
      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end
    end
  end
end
