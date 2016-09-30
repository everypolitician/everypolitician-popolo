module Everypolitician
  module Popolo
    class Election < Event
      def self.matches_classification(classification)
        classification.include? 'election'
      end
    end
    class Elections < Collection
      entity_class Election
    end
  end
end
