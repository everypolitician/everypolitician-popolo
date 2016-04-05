module Everypolitician
  module Popolo
    class Organizations < Collection
      def popolo_key
        :organizations
      end
    end

    class Organization < Entity; end
  end
end
