module Blakey
  module Repository
    class Base
      class SourceRequired < StandardError; end

      def initialize(source = nil, options = {})
        @source  = source
        @options = options

        raise SourceRequired, "Please pass a valid source" unless source
      end

      attr_reader :options

      def source_overview
        source.repository_overview
      end

      private

      attr_reader :source
    end
  end
end
