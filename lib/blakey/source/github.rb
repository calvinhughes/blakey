require 'base64'
require 'octokit'

module Blakey
  module Source
    class Github < Base
      def initialize(access_token: nil, repo_path: nil)
        @access_token = (access_token || ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'])
        @octokit_client ||= ::Octokit::Client.new(access_token: @access_token)
        @repo_path = repo_path
      end

      attr_reader :repo_path

      def read_file(file_path)
        begin
          encoded_file_content = octokit_client.contents(repo_path, path: file_path).content
        rescue Octokit::NotFound => e
          raise FileNotFound.new(e)
        end

        Base64.decode64(encoded_file_content).chomp
      end

      def repository_overview
        {
          open_issues_count: repository.open_issues_count,
          language: repository.language,
          visibility: repository.private? ? 'private' : 'public',
          url: repository.html_url,
          updated_at: repository.updated_at,
          created_at: repository.created_at,
          last_pushed_at: repository.pushed_at
        }
      end

      private

      def repository
        @repository ||= octokit_client.repo(repo_path)
      end

      attr_reader :octokit_client
    end
  end
end
