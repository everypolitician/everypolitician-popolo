module Everypolitician
  module Popolo
    class Organization < Entity
      def classification
        document.fetch(:classification, nil)
      end

      def identifiers
        document.fetch(:identifiers, [])
      end

      def image
        document.fetch(:image, nil)
      end

      def links
        document.fetch(:links, [])
      end

      def name
        document.fetch(:name, nil)
      end

      def other_names
        document.fetch(:other_names, [])
      end

      def srgb
        document.fetch(:srgb, nil)
      end
      alias associated_colour srgb
      alias associated_color srgb
    end

    class Organizations < ClassificationCollection
      entity_class Organization

      def legislatures
        of_class(Legislature)
      end

      def parties
        of_class(Party)
      end
    end
  end
end
