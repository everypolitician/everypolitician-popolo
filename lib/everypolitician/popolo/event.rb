require 'pry'
module Everypolitician
  module Popolo
    class Event < Entity
      attr_reader   :start_date,
                    :end_date,
                    :id,
                    :name,
                    :classification,
                    :organization_id,
                    :wikidata

      def initialize(event, _popolo = nil)
        @start_date = event[:start_date]
        @end_date = event[:end_date]
        @id = event[:id]
        @name = event[:name]
        @classification = event[:classification]
        @organization_id = event[:organization_id]
        @wikidata = event[:wikidata]
      end
    end

    class Events < Collection
      entity_class Event
    end
  end
end
