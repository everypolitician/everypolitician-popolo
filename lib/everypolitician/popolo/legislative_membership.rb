module Everypolitician
  module Popolo
    class LegislativeMembership < Membership
      classification 'legislature'
    end
    class LegislativeMemberships < Memberships
      entity_class LegislativeMembership
    end
  end
end
