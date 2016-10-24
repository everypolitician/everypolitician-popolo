module Everypolitician
  module Popolo
    class Election < Event
      classification 'general election'
    end
    class Elections < Collection
      entity_class Election
    end
  end
end
