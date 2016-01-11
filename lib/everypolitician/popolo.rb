require 'everypolitician/popolo/version'

module Everypolitician
  module Popolo
    class Error < StandardError; end

    class JSON
      attr_reader :popolo

      def initialize(popolo)
        @popolo = popolo
      end

      def persons
        People.new(popolo[:persons])
      end
    end

    class People
      include Enumerable

      attr_reader :documents

      def initialize(documents)
        @documents = documents.map { |p| Person.new(p) }
      end

      def each(&block)
        documents.each(&block)
      end
    end

    class Person
      class Error < StandardError; end

      attr_reader :document

      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end

      def [](key)
        document[key]
      end

      def key?(key)
        document.key?(key)
      end

      def links
        document.fetch(:links, [])
      end

      def twitter
        if key?(:contact_details)
          if twitter_contact = self[:contact_details].find { |d| d[:type] == 'twitter' }
            twitter_contact[:value].strip
          end
        elsif key?(:links)
          if twitter_link = self[:links].find { |d| d[:note][/twitter/i] }
            twitter_link[:url].strip
          end
        end
      end

      def facebook
        facebook_link = links.find { |d| d[:note] == 'facebook' }
        facebook_link[:url] if facebook_link
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

EveryPolitician = Everypolitician
