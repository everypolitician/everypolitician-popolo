module Everypolitician
  module Popolo
    class Party < Organization
      classification 'party'
    end

    class Parties < Organizations
      entity_class Party
    end
  end
end
