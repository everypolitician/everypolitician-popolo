# frozen_string_literal: true

require_relative 'collection'
require_relative 'event'

module Everypolitician
  module Popolo
    class Election < Event
      classification 'general election'
    end
    class Elections < Collection
      entity_class Election
    end
  end
end
