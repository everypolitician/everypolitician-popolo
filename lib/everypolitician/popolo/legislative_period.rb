module Everypolitician
  module Popolo
    class LegislativePeriods < Collection
      def size
        to_a.size
      end

      def last
        to_a.last
      end

      def to_a
        map { |x| x }
      end
    end
    class LegislativePeriod < Entity
      attr_accessor :start_date, :end_date

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
