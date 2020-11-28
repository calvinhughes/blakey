require_relative 'lib/blakey/version'

Gem::Specification.new do |spec|
  spec.name          = "blakey"
  spec.version       = Blakey::VERSION
  spec.authors       = ["Calvin Hughes"]
  spec.email         = ["calvin@veeqo.com"]

  spec.summary       = "Blakey makes extracting basic statistics from your projects much easier"
  spec.description   = "Blakey is a Ruby gem built to make extract basic statistics and information from your repositories/projects much easier"
  spec.homepage      = "https://github.com/calvinhughes/blakey"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/calvinhughes/blakey"
  spec.metadata["changelog_uri"] = "https://github.com/calvinhughes/blakey/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'octokit', '~> 4.19'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'webmock', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 6.0'
end
