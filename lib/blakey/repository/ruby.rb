module Blakey
  module Repository
    class Ruby < Base
      def gem_dependency_version(gem_name)
        gem_dependencies.fetch(gem_name, nil)
      end

      def gem_dependencies
        gemfile_lock_parser.dependencies
      end

      def ruby_version
        ruby_version_fetcher.version
      end

      private

      attr_reader :source

      def ruby_version_fetcher
        @ruby_version_fetcher ||= RubyVersionFetcher.new(
          gemfile_lock_parser: gemfile_lock_parser,
          source: source
        )
      end

      def gemfile_lock_parser
        @gemfile_lock_parser ||= GemfileLockParser.new(
          gemfile_lock_path: options[:gemfile_lock_path],
          source: source
        )
      end
    end
  end
end
