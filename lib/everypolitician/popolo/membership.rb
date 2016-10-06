module Everypolitician
  module Popolo
    class Membership < Entity
      def person_id
        document.fetch(:person_id, nil)
      end

      def on_behalf_of_id
        document.fetch(:on_behalf_of_id, nil)
      end

      def organization_id
        document.fetch(:organization_id, nil)
      end

      def area_id
        document.fetch(:area_id, nil)
      end

      def role
        document.fetch(:role, nil)
      end

      def start_date
        document.fetch(:start_date, nil)
      end

      def end_date
        document.fetch(:end_date, nil)
      end

      def person
        popolo.persons.find_by(id: person_id)
      end

      def ==(other)
        self.class == other.class && instance_variables.all? { |v| instance_variable_get(v) == other.instance_variable_get(v) }
      end
      alias eql? ==
    end

    class Memberships < Collection
      entity_class Membership
    end
  end
end
