module Everypolitician
  module Popolo
    class Legislature < Organization
      classification 'legislature'

      def seats
        document.fetch(:seats, nil)
      end
    end

    class Legislatures < Organizations
      entity_class Legislature
    end
  end
end
