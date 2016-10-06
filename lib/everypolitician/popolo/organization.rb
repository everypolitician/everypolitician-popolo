module Everypolitician
  module Popolo
    class Organization < EntityWithDynamicMethods
      def wikidata
        identifier('wikidata')
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
