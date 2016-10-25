module Everypolitician
  module Popolo
    class Legislature < Organization
      def seats
        document.fetch(:seats, nil)
      end
    end

    class Legislatures < Organizations
      entity_class Legislature
    end
  end
end
