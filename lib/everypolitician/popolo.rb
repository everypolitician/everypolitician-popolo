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

    # Reads and parses a Popolo file
    #
    # @param popolo_file [String] path to the file
    # @return [Everypolitician::Popolo::JSON] the parsed Popolo data
    def self.read(popolo_file)
      parse(File.read(popolo_file))
    end

    # Parses a string of Popolo data
    #
    # @param popolo_string [String] JSON Popolo data as a String
    # @return [Everypolitician::Popolo::JSON] the parsed Popolo data
    def self.parse(popolo_string)
      popolo = ::JSON.parse(popolo_string, symbolize_names: true)
      Everypolitician::Popolo::JSON.new(popolo)
    end

    class JSON
      # @return [::JSON] raw Popolo JSON
      attr_reader :popolo

      def initialize(popolo)
        @popolo = popolo
      end

      # @return [People] the people in this Popolo
      def persons
        People.new(popolo[:persons])
      end

      # @return [Organizations] the organizations in this Popolo
      def organizations
        Organizations.new(popolo[:organizations])
      end

      # @return [Areas] the areas in this Popolo
      def areas
        Areas.new(popolo[:areas])
      end

      # @return [Events] the events in this Popolo
      def events
        Events.new(popolo[:events])
      end

      # @return [Memberships] the memberships in this Popolo
      def memberships
        Memberships.new(popolo[:memberships])
      end
    end
  end
end

EveryPolitician = Everypolitician
