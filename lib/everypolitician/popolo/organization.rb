module Everypolitician
  module Popolo
    class Organization < Entity
      attr_reader :classification,
                  :identifiers,
                  :image,
                  :links,
                  :name,
                  :other_names,
                  :seats

      def initializer(p, _popolo = nil)
        @classification = p[:classification]
        @identifiers = p[:identifiers]
        @image = p[:image]
        @links = p[:links]
        @name = p[:name]
        @other_names = p[:other_names]
        @seats = p[:seats]
      end

      def wikidata
        identifier('wikidata')
      end

      private

      def identifier(scheme_name)
        identifiers.find { |i| i[:scheme] == scheme_name }[:identifier] rescue nil
      end
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
