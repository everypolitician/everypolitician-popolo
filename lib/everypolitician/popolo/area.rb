module Everypolitician
  module Popolo
    class Area < Entity; end

    class Areas < Collection
      entity_class Area
    end
  end
end
