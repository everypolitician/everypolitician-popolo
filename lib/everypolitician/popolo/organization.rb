module Everypolitician
  module Popolo
    class Organizations < Collection; end

    class Organization < Entity
      def wikidata
        identifier('wikidata')
      end
    end
  end
end
