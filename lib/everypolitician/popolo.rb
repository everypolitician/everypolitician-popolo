require 'everypolitician/popolo/version'
require 'json'

module Everypolitician
  module Popolo
    class Error < StandardError; end

    def self.read(popolo_file)
      parse(File.read(popolo_file))
    end

    def self.parse(popolo_string)
      popolo = ::JSON.parse(popolo_string, symbolize_names: true)
      Everypolitician::Popolo::JSON.new(popolo)
    end

    class JSON
      attr_reader :popolo

      def initialize(popolo)
        @popolo = popolo
      end

      def persons
        People.new(popolo[:persons])
      end

      def organizations
        Organizations.new(popolo[:organizations])
      end
    end

    class Collection
      include Enumerable

      attr_reader :documents

      def each(&block)
        documents.each(&block)
      end

      def -(other)
        other_ids = Set.new(other.documents.map(&:id))
        documents.reject { |d| other_ids.include?(d.id) }
      end
    end

    class People < Collection
      def initialize(documents)
        @documents = documents.map { |p| Person.new(p) }
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

      def ==(other)
        id == other.id
      end
      alias eql? ==

      def links
        document.fetch(:links, [])
      end

      def identifiers
        document.fetch(:identifiers, [])
      end

      def identifier(scheme)
        identifiers.find(->{{}}) { |i| i[:scheme] == scheme }[:identifier]
      end

      def email
        self[:email]
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

      def sort_name
        name
      end

      def image
        self[:image]
      end

      def gender
        self[:gender]
      end
    end

    class Organizations < Collection
      def initialize(documents)
        @documents = documents.map { |p| Organization.new(p) }
      end
    end

    class Organization
      attr_reader :document

      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end

      def ==(other)
        id == other.id
      end
      alias eql? ==
    end
  end
end

EveryPolitician = Everypolitician
