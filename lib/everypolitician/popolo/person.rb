module Everypolitician
  module Popolo
    class Person < Entity
      class Error < StandardError; end

      def initializer(document, _popolo = nil)
        @document = document
      end

      def family_name
        document[:family_name]
      end

      def given_name
        document[:given_name]
      end

      def identifiers
        document[:identifiers]
      end

      def images
        document[:images]
      end

      def other_names
        document[:other_names]
      end

      def sources
        document[:sources]
      end

      def email
        document[:email]
      end

      def image
        document[:image]
      end

      def gender
        document[:gender]
      end

      def birth_date
        document[:birth_date]
      end

      def death_date
        document[:death_date]
      end

      def honorific_prefix
        document[:honorific_prefix]
      end

      def honorific_suffix
        document[:honorific_suffix]
      end

      def links
        document.fetch(:links, [])
      end

      def contact_details
        document.fetch(:contact_details, [])
      end

      def phone
        contact('phone')
      end

      def fax
        contact('fax')
      end

      def twitter
        contact('twitter') || link('twitter')
      end

      def facebook
        link('facebook')
      end

      def wikidata
        identifier('wikidata')
      end

      def sort_name
        document[:name]
      end

      def memberships
        popolo.memberships.where(person_id: id)
      end

      private

      def name_at(date)
        return name unless key?(:other_names)
        historic = other_names.select { |n| n.key?(:end_date) }
        return name if historic.empty?
        at_date = historic.select do |n|
          n[:end_date] >= date && (n[:start_date] || '0000-00-00') <= date
        end
        return name if at_date.empty?
        fail Error, "Too many names at #{date}: #{at_date}" if at_date.count > 1
        at_date.first[:name]
      end

      def identifier(scheme_name)
        identifiers.find { |i| i[:scheme] == scheme_name }[:identifier] rescue nil
      end

      def contact(type)
        contact_details.find(-> { {} }) { |i| i[:type] == type }[:value]
      end

      def link(type)
        links.find(-> { {} }) { |i| i[:note] == type }[:url]
      end
    end

    class People < Collection
      entity_class Person
    end
  end
end
