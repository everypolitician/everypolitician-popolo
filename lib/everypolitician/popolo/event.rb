module Everypolitician
  module Popolo
    class Event < Entity
      attr_accessor :start_date, :end_date
    end

    class Events < Collection
      entity_class Event
    end
  end
end
