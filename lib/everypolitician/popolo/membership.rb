module Everypolitician
  module Popolo
    class Memberships < Collection
      def popolo_key
        :memberships
      end
    end

    class Membership < Entity
      attr_accessor :person_id, :on_behalf_of_id, :organization_id, :area_id, :role, :start_date, :end_date
    end
  end
end
