require 'everypolitician/popolo/version'
require 'everypolitician/popolo/collection'
require 'everypolitician/popolo/person'
require 'everypolitician/popolo/organization'
require 'everypolitician/popolo/area'
require 'everypolitician/popolo/event'
require 'everypolitician/popolo/membership'
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
  end
end

EveryPolitician = Everypolitician
