require 'everypolitician/popolo/version'
require 'everypolitician/popolo/collection'
require 'everypolitician/popolo/people'
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

      def areas
        Areas.new(popolo[:areas])
      end

      def events
        Events.new(popolo[:events])
      end

      def memberships
        Memberships.new(popolo[:memberships])
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

    class Areas < Collection
      def initialize(documents)
        @documents = documents.map { |p| Area.new(p) }
      end
    end

    class Area
      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end
    end

    class Events < Collection
      def initialize(documents)
        @documents = documents.map { |p| Event.new(p) }
      end
    end

    class Event
      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end
    end

    class Memberships < Collection
      def initialize(documents)
        @documents = documents.map { |p| Membership.new(p) }
      end
    end

    class Membership
      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end

      def start_date
        @document[:start_date]
      end

      def end_date
        @document[:end_date]
      end
    end
  end
end

EveryPolitician = Everypolitician
