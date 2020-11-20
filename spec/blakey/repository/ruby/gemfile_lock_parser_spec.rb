# frozen_string_literal: true

describe Blakey::Repository::Ruby::GemfileLockParser do
  let(:source) { Blakey::Source::Github.new(repo_path: 'calvinhughes/blakey', access_token: 'foo') }

  subject { Blakey::Repository::Ruby::GemfileLockParser.new(source: source) }

  let(:gemfile_lock_contents) do
    fixture('repository/ruby/gemfile_with_ruby_version.lock').read
  end

  before do
    allow(source).to receive(:read_file).with('Gemfile.lock').and_return(gemfile_lock_contents)
  end

  describe '#gemfile_lock_path' do
    context 'when a gemfile_lock_path is specified' do
      subject { Blakey::Repository::Ruby::GemfileLockParser.new(gemfile_lock_path: 'custom_gemfile.lock', source: source) }

      it 'reads the dependency contents from the specified path' do
        expect(source).to receive(:read_file).with('custom_gemfile.lock').and_return(gemfile_lock_contents)
        subject.dependencies
      end
    end

    context 'when a gemfile_lock_path is not specified' do
      subject { Blakey::Repository::Ruby::GemfileLockParser.new(source: source) }

      it 'reads the dependency contents from default path of Gemfile.lock' do
        expect(source).to receive(:read_file).with('Gemfile.lock')
        subject.dependencies
      end
    end
  end

  describe '#ruby_version' do
    context 'when gemfile has no ruby version set' do
      let(:gemfile_lock_contents) do
        fixture('repository/ruby/gemfile_without_ruby_version.lock').read
      end

      it { expect(subject.ruby_version).to be_nil }
    end

    context 'when gemfile has a ruby version set' do
      let(:gemfile_lock_contents) do
        fixture('repository/ruby/gemfile_with_ruby_version.lock').read
      end

      it { expect(subject.ruby_version).to eq('2.7.1') }
    end
  end

  describe '#dependencies' do
    it 'returns a hash of the installed gems and their versions' do
      expect(subject.dependencies).to eq({
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
      })
    end
  end
end
