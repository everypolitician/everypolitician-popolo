# frozen_string_literal: true

require 'json'
require 'require_all'

require_rel 'popolo'

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
        @persons ||= People.new(popolo[:persons], self)
      end

      def organizations
        @organizations ||= Organizations.new(popolo[:organizations], self)
      end

      def areas
        @areas ||= Areas.new(popolo[:areas], self)
      end

      def events
        # do the sorting at the popolo level so we still get an Events object back
        @events ||= Events.new(popolo[:events].to_a.sort_by { |e| e[:start_date].to_s }, self)
      end

      def posts
        @posts ||= Posts.new(popolo[:posts], self)
      end

      def memberships
        @memberships ||= Memberships.new(popolo[:memberships], self)
      end

      def elections
        @elections ||= events.elections
      end

      def legislative_periods
        @legislative_periods ||= events.legislative_periods
      end
      alias terms legislative_periods

      def latest_legislative_period
        legislative_periods.max_by(&:start_date)
      end
      alias latest_term latest_legislative_period

      alias current_legislative_period latest_legislative_period
      alias current_term latest_legislative_period
    end
  end
end

EveryPolitician = Everypolitician
