module Everypolitician
  module Popolo
    class LegislativePeriod < Event
      event_classification 'legislative period'
    end
    class LegislativePeriods < Collection
      entity_class LegislativePeriod
    end
  end
end
