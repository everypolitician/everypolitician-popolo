module Everypolitician
  module Popolo
    class Membership < EntityWithDynamicMethods
      attr_accessor :person_id, :on_behalf_of_id, :organization_id, :area_id, :role, :start_date, :end_date

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
