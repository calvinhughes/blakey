require 'bundler'

module Blakey
  module Repository
    class Ruby::RubyVersionFetcher

      def initialize(gemfile_lock_parser:, source:)
        @gemfile_lock_parser = gemfile_lock_parser
        @source              = source
      end

      def version
        gemfile_lock_parser.ruby_version || fetch_version_from_ruby_version_file
      end

      private

      attr_reader :gemfile_lock_parser, :source

      def fetch_version_from_ruby_version_file
        source.read_file('.ruby-version')
      end
    end
  end
end
