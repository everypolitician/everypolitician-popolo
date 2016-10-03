module Everypolitician
  module Popolo
    class Election < Event
    end
    class Elections < Collection
      entity_class Election
    end
  end
end
