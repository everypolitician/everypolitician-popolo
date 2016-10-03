module Everypolitician
  module Popolo
    class LegislativePeriod < Event
      classification 'legislative period'

      def memberships
        @memberships ||= popolo.memberships.where(legislative_period_id: id)
      end
    end
    class LegislativePeriods < Collection
      entity_class LegislativePeriod
    end
  end
end
