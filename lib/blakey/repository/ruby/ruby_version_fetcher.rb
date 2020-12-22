require 'bundler'

module Blakey
  module Repository
    class Ruby::RubyVersionFetcher

      def initialize(gemfile_lock_parser:, source:)
        @gemfile_lock_parser = gemfile_lock_parser
        @source              = source
      end

      def version
        format_version(fetched_version)
      end

      private

      attr_reader :gemfile_lock_parser, :source

      def format_version(version_string)
        version_string.gsub(/^(.*?)(?=[0-9])/, '').strip
      end

      def fetched_version
        gemfile_lock_parser.ruby_version || fetch_version_from_ruby_version_file
      end

      def fetch_version_from_ruby_version_file
        source.read_file('.ruby-version')
      end
    end
  end
end
