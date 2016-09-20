module Everypolitician
  module Popolo
    class Events < Collection; end
    class Event < Entity
      attr_accessor :start_date, :end_date

      def people
        ids = popolo.memberships.select { |m| m.legislative_period_id == id }
                    .map(&:person_id)
        popolo.persons.select { |p| ids.include? p.id }
      end
    end
  end
end
