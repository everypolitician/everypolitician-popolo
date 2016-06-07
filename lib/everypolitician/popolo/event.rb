module Everypolitician
  module Popolo
    class Events < Collection; end
    class Event < Entity; 
      attr_accessor :start_date, :end_date
    end
  end
end
