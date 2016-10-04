module Everypolitician
  module Popolo
    class Area < EntityWithDynamicMethods; end

    class Areas < Collection
      entity_class Area
    end
  end
end
