module Everypolitician
  module Popolo
    class Event < Entity
      attr_accessor :start_date, :end_date

      def people
        raise NotImplementedError unless classification == 'legislative period'
        ids = popolo.memberships.select { |m| m.legislative_period_id == id }
                    .map(&:person_id)
        popolo.persons.select { |p| ids.include? p.id }
      end

      def organizations
        raise NotImplementedError unless classification == 'legislative period'
        ids = popolo.memberships.select { |m| m.legislative_period_id == id }
                    .map(&:on_behalf_of_id)
        popolo.organizations.select { |o| ids.include? o.id }
      end
    end

    class Events < Collection
      entity_class Event
    end
  end
end
