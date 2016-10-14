module Everypolitician
  module Popolo
    class LegislativePeriod < Event
      classification 'legislative period'
    end
    class LegislativePeriods < Collection
      entity_class LegislativePeriod
    end
  end
end
