module Everypolitician
  module Popolo
    class Memberships < Collection; end

    class Membership < Entity
      self.attributes = %i(id person_id on_behalf_of_id organization_id area_id role start_date end_date).to_set
    end
  end
end
