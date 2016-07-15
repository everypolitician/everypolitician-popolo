module Everypolitician
  module Popolo
    class People < Collection; end

    class Person < Entity
      class Error < StandardError; end

      attr_accessor :email, :image, :gender, :birth_date, :death_date, :honorific_prefix, :honorific_suffix

      def links
        document.fetch(:links, [])
      end

      def identifiers
        document.fetch(:identifiers, [])
      end

      def contact_details
        document.fetch(:contact_details, [])
      end

      def contact(type)
        contact_details.find(->{{}}) { |i| i[:type] == type }[:value]
      end

      def phone
        contact('phone')
      end

      def fax
        contact('fax')
      end

      def twitter
        if key?(:contact_details)
          if twitter_contact = self[:contact_details].find { |d| d[:type] == 'twitter' }
            return twitter_contact[:value].strip
          end
        end
        if key?(:links)
          if twitter_link = self[:links].find { |d| d[:note][/twitter/i] }
            return twitter_link[:url].strip
          end
        end
      end

      def facebook
        facebook_link = links.find { |d| d[:note] == 'facebook' }
        facebook_link[:url] if facebook_link
      end

      def wikidata
        identifier('wikidata')
      end

      def sort_name
        name
      end

      def name_at(date)
        return name unless key?(:other_names)
        historic = other_names.find_all { |n| n.key?(:end_date) }
        return name if historic.empty?
        at_date = historic.find_all do |n|
          n[:end_date] >= date && (n[:start_date] || '0000-00-00') <= date
        end
        return name if at_date.empty?
        fail Error, "Too many names at #{date}: #{at_date}" if at_date.count > 1
        at_date.first[:name]
      end
    end
  end
end
