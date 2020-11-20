# frozen_string_literal: true

module Blakey
  module Source
    class Base
      def read_file(file_path)
        raise 'To be implemented'
      end

      def repository_overview
        raise 'To be implemented'
      end
    end
  end
end
