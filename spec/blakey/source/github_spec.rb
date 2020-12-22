# frozen_string_literal: true

describe Blakey::Source::Github do
  subject { Blakey::Source::Github.new(repo_path: 'calvinhughes/blakey', access_token: blakey_test_source_github_access_token) }

  describe '#repository_overview' do
    it 'returns the repository stats from the GitHub API', :vcr do
      expect(subject.repository_overview).to eq({
        open_issues_count: 2,
        open_pull_requests_count: 1,
        language: 'Ruby',
        visibility: 'public',
        url: 'https://github.com/calvinhughes/blakey',
        updated_at: Time.parse('2020-12-22T22:56:00Z'),
        created_at: Time.parse('2020-11-21T14:51:30Z'),
        last_pushed_at: Time.parse('2020-12-22T22:59:10Z')
      })
    end
  end

  describe '#read_file' do
    context 'when file exists' do
      it 'returns the contents of the file from the GitHub API', :vcr do
        expect(subject.read_file('README.md')).to include('Blakey')
      end
    end

    context 'when file does not exist' do
      it 'raises Source::Base::FileNotFound', :vcr do
        expect { subject.read_file('non_existant_file.json') }.to raise_error(
          Blakey::Source::FileNotFound,
          /non_existant_file.json: 404 - Not Found/
        )
      end
    end
  end

  describe 'access token' do
    context 'when access token is not set' do
      subject { Blakey::Source::Github.new(repo_path: 'calvinhughes/blakey') }

      context 'when BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN environment variable is set' do
        let(:existing_blakey_source_github_access_token) { ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'] }

        before { ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'] = 'access_token_from_env' }

        after { ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'] = existing_blakey_source_github_access_token }

        it 'uses the access token from the environment variable' do
          expect(subject.instance_variable_get(:@access_token)).to eq('access_token_from_env')
        end
      end

      context 'when BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN environment variable is not set' do
        let(:existing_blakey_source_github_access_token) { ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'] }

        before { ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'] = nil }

        after { ENV['BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN'] = existing_blakey_source_github_access_token }

        it 'uses the access token from the environment variable' do
          expect(subject.instance_variable_get(:@access_token)).to eq(nil)
        end
      end
    end

    context 'when access token is set' do
      subject { Blakey::Source::Github.new(repo_path: 'calvinhughes/blakey', access_token: 'a_specified_access_token') }

      it 'uses the specified access token' do
        expect(subject.instance_variable_get(:@access_token)).to eq('a_specified_access_token')
      end
    end
  end
end
