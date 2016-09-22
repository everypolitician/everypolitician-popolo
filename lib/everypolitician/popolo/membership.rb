module Everypolitician
  module Popolo
    class Membership < Entity
      attr_accessor :person_id, :on_behalf_of_id, :organization_id, :area_id, :role, :start_date, :end_date

      def person
        popolo.persons.find_by(id: person_id)
      end
    end

    class Memberships < Collection
    end
  end
end
