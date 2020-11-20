# frozen_string_literal: true

describe Blakey::Repository::Ruby do
  let(:source) { Blakey::Source::Github.new(repo_path: 'calvinhughes/blakey', access_token: 'foo') }

  subject do
    Blakey::Repository::Ruby.new(
      source,
      gemfile_lock_path: 'custom_gemfile_lock_path.lock'
    )
  end

  describe '#ruby_version' do
    let(:ruby_version_fetcher_instance) { instance_double(Blakey::Repository::Ruby::RubyVersionFetcher) }
    let(:gemfile_lock_parser_instance) { instance_double(Blakey::Repository::Ruby::GemfileLockParser) }

    before do
      allow(subject).to receive(:gemfile_lock_parser).and_return(gemfile_lock_parser_instance)
    end

    it 'calls ruby version fetcher and returns ruby version installed' do
      expect(Blakey::Repository::Ruby::RubyVersionFetcher)
        .to receive(:new)
        .with(gemfile_lock_parser: gemfile_lock_parser_instance, source: source)
        .and_return(ruby_version_fetcher_instance)
      expect(ruby_version_fetcher_instance).to receive(:version).and_return('2.7.1')

      expect(subject.ruby_version).to eq('2.7.1')
    end
  end

  describe 'dependencies' do
    let(:gemfile_lock_parser_instance) { instance_double(Blakey::Repository::Ruby::GemfileLockParser) }

    let(:dependencies) do
      {
        'addressable' => '2.7.0',
        'blakey' => '0.1.0',
        'diff-lcs' => '1.4.4',
        'faraday' => '1.1.0',
        'multipart-post' => '2.1.1',
        'octokit' => '4.19.0',
        'public_suffix' => '4.0.6',
        'rake' => '12.3.3',
        'rspec' => '3.10.0',
        'rspec-core' => '3.10.0',
        'rspec-expectations' => '3.10.0',
        'rspec-mocks' => '3.10.0',
        'rspec-support' => '3.10.0',
        'ruby2_keywords' => '0.0.2',
        'sawyer' => '0.8.2'
      }
    end

    describe '#gem_dependencies' do
      it 'calls gemfile lock parser with the correct params and returns a hash of the installed gems and their versions' do
        expect(Blakey::Repository::Ruby::GemfileLockParser)
          .to receive(:new)
          .with(gemfile_lock_path: 'custom_gemfile_lock_path.lock', source: source)
          .and_return(gemfile_lock_parser_instance)
        expect(gemfile_lock_parser_instance).to receive(:dependencies).and_return(dependencies)

        expect(subject.gem_dependencies).to eq(dependencies)
      end
    end

    describe '#gem_dependency_version' do
      it 'calls gemfile lock parser with the correct params and returns the installed version for the specific gem dependency' do
        expect(Blakey::Repository::Ruby::GemfileLockParser)
          .to receive(:new)
          .with(gemfile_lock_path: 'custom_gemfile_lock_path.lock', source: source)
          .and_return(gemfile_lock_parser_instance)
        expect(gemfile_lock_parser_instance).to receive(:dependencies).and_return(dependencies)

        expect(subject.gem_dependency_version('blakey')).to eq('0.1.0')
      end
    end
  end
end
