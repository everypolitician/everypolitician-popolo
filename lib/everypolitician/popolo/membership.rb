module Everypolitician
  module Popolo
    class Memberships < Collection; end

    class Membership
      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end

      def start_date
        @document[:start_date]
      end

      def end_date
        @document[:end_date]
      end
    end
  end
end
