module Everypolitician
  module Popolo
    class Events < Collection; end
    class MethodNotImplementedError < StandardError; end
    class Event < Entity
      attr_accessor :start_date, :end_date

      def people
        raise MethodNotImplementedError unless classification == 'legislative period'
      end

      def organizations
        raise MethodNotImplementedError unless classification == 'legislative period'
      end
    end
  end
end
