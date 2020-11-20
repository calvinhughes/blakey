# frozen_string_literal: true

describe Blakey::Repository::Ruby::GemfileLockParser do
  let(:source) { Blakey::Source::Github.new(repo_path: 'calvinhughes/blakey', access_token: 'foo') }

  let(:gemfile_lock_parser) do
    Blakey::Repository::Ruby::GemfileLockParser.new(source: source)
  end

  before do
    allow(source).to receive(:read_file).with('.ruby-version').and_return('2.6.5')
  end

  subject do
    Blakey::Repository::Ruby::RubyVersionFetcher.new(gemfile_lock_parser: gemfile_lock_parser, source: source)
  end

  describe '#version' do
    context 'when gemfile lock has ruby version' do
      before { allow(gemfile_lock_parser).to receive(:ruby_version).and_return('2.7.1') }

      it 'returns the version from the gemfile lock' do
        expect(source).not_to receive(:read_file).with('.ruby-version')

        expect(subject.version).to eq('2.7.1')
      end
    end

    context 'when gemfile lock does not have ruby version' do
      before { allow(gemfile_lock_parser).to receive(:ruby_version).and_return(nil) }

      it 'falls back to .ruby-version file' do
        expect(source).to receive(:read_file).with('.ruby-version')

        expect(subject.version).to eq('2.6.5')
      end
    end
  end
end
