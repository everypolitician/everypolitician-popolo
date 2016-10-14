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

      # TODO: this should be pushed into a Legislature class when we split
      # this into Party and Legislature classes
      def seats
        document.fetch(:seats, nil)
      end

      def srgb
        document.fetch(:srgb, nil)
      end
      alias associated_colour srgb
      alias associated_color srgb
    end

    class Organizations < Collection
      entity_class Organization
    end
  end
end
