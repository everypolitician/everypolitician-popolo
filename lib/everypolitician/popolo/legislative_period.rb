module Everypolitician
  module Popolo
    class LegislativePeriod < Event
      def people
        ids = memberships.map(&:person_id).to_set
        popolo.persons.select { |p| ids.include? p.id }
      end

      def organizations
        ids = memberships.map(&:on_behalf_of_id).to_set
        popolo.organizations.select { |o| ids.include? o.id }
      end

      private

      def memberships
        popolo.memberships.where(legislative_period_id: id)
      end
    end
  end
end
