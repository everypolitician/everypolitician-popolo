module Everypolitician
  module Popolo
    class Organization < Entity
      def wikidata
        identifier('wikidata')
      end
    end

    class Organizations < Collection
    end
  end
end
