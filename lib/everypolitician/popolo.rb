require 'everypolitician/popolo/version'
require 'everypolitician/popolo/collection'
require 'everypolitician/popolo/entity'
require 'everypolitician/popolo/person'
require 'everypolitician/popolo/organization'
require 'everypolitician/popolo/area'
require 'everypolitician/popolo/event'
require 'everypolitician/popolo/post'
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

      def posts
        Posts.new(popolo[:posts])
      end

      def memberships
        Memberships.new(popolo[:memberships])
      end

      def legislative_periods
        events.where(classification: 'legislative period').sort_by(&:start_date)
      end
      alias_method :terms, :legislative_periods

      def current_legislative_period
        legislative_periods[-1]
      end
      alias_method :current_term, :current_legislative_period
    end
  end
end

EveryPolitician = Everypolitician
