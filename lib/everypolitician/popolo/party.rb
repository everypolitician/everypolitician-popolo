module Everypolitician
  module Popolo
    class Party < Organization
    end

    class Parties < Organizations
      entity_class Party
    end
  end
end
