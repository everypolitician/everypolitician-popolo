module Everypolitician
  module Popolo
    class Areas < Collection
      def popolo_key
        :areas
      end
    end

    class Area < Entity; end
  end
end
