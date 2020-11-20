# Ruby
A repository type that is used for Ruby programs and applications. This repository allows you to fetch information such as the Ruby version, the gems in use along with their versions.

## Configuration options

|Configuration option|Description |
|----------------------|-------------|
|source|The source for the data. See [Sources](/doc/sources) for more information|
|gemfile_lock_path|Custom path to the Gemfile.lock in the source. Default: `Gemfile.lock`|

## Example usage

#### Build repository object
```ruby
example_source = Blakey::Source::GitHub.new(access_token: 'personal_access_token', repo_path: 'calvinhughes/blakey')

repository = Blakey::Repository::Ruby.new(source, gemfile_lock_path: 'custom_gemfile_lock_path.lock')
```

#### Retrieve Ruby version
Uses `Gemfile.lock` as the source of the Ruby version, falling back to `.ruby-version`

```ruby
repository.ruby_version
# => "2.7.1"
```

#### Retrieve list of gem dependencies and their version
```ruby
repository.gem_dependencies
# => {"rails" => "6.0.1", "blakey" => "0.1.0"}
```

#### Retrieve version for a specific gem dependency
```ruby
repository.gem_dependency_version('rails')
# => "6.0.1"
```
