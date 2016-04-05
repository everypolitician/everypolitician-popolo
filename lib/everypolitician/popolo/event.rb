module Everypolitician
  module Popolo
    class Events < Collection
      def popolo_key
        :events
      end
    end

    class Event < Entity; end
  end
end
