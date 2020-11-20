require 'bundler'

module Blakey
  module Repository
    class Ruby::GemfileLockParser
      DEFAULT_GEMFILE_LOCK_PATH = 'Gemfile.lock'

      def initialize(gemfile_lock_path: nil, source:)
        @gemfile_lock_path = (gemfile_lock_path || DEFAULT_GEMFILE_LOCK_PATH)
        @source            =  source
      end

      attr_reader :gemfile_lock_path

      def dependencies
        parsed_gemfile_lock.specs.map { |spec| [spec.name, spec.version.to_s] }.to_h
      end

      def ruby_version
        parsed_gemfile_lock.ruby_version
      end

      private

      attr_reader :source

      def parsed_gemfile_lock
        @parsed_gemfile_lock ||= Bundler::LockfileParser.new(gemfile_lock_contents)
      end

      def gemfile_lock_contents
        source.read_file(gemfile_lock_path)
      end
    end
  end
end
