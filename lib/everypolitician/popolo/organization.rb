module Everypolitician
  module Popolo
    class Organizations < Collection
      def initialize(documents)
        @documents = documents ? documents.map { |p| Organization.new(p) } : []
      end
    end

    class Organization
      attr_reader :document

      def initialize(document)
        @document = document
        document.each do |key, value|
          define_singleton_method(key) { value }
        end
      end

      def ==(other)
        id == other.id
      end
      alias eql? ==
    end
  end
end