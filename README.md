# Blakey

[![Build Status](https://travis-ci.org/calvinhughes/blakey.svg?branch=main)](https://travis-ci.org/calvinhughes/blakey) [![Gem Version](https://badge.fury.io/rb/blakey.svg)](https://badge.fury.io/rb/blakey)

Blakey is a Ruby gem built to take the hassle out of extracting useful information from your projects. It allows you to easily plug in sources of information about your project, which can then be used as a common data-source for reporting purposes.

Easily find out information like..

- What language versions are used?
- Which dependencies do I have and what are their versions?
- What is the state of the remote repository? How many issues are open?
- Are GitHub vulnerability alerts enabled for the project's GitHub repository?

Blakey is built to be extendable out of the box, meaning you can easily add your own custom sources and repository types if they are not supported already.

## Understanding Blakey
Blakey consists of two main parts:

#### Source
Where the base data and any files used for inspecting are retrieved from. For example: GitHub, GitLab, manual git repository or local file systems.

Supported sources:

- [GitHub](/doc/sources/GitHub.md)

#### Repository
The repository/project that is being inspected. Repositories must be of a particular language type (for example: Ruby, JavaScript), and must take a source. This repository then has the specific information related to the repository type itself, such as the specific language versions in use or dependencies that are loaded.

Supported repository types:

- [Ruby](/doc/repositories/Ruby.md)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blakey'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install blakey

## Usage
To get started, build a source object:
```ruby
# Add a GitHub personal access token for the access_token value
# This can also be set via BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN environment variable

github_source = Blakey::Source::Github.new(access_token: 'token', repo_path: 'calvinhughes/blakey')
```

Then build a repository object (for example Ruby):
```ruby
repository = Blakey::Repository::Ruby.new(source)
```

You can then run any of the supported methods on the repository or the source. See the following docs for what repositories and sources are supported and their examples:

- [Sources](/doc/sources)
- [Repositories](/doc/repositories)


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Some sources using remote APIs in the development environment may require authentication. You can specify credentials for these using the following environment variables:

| Source | Environment variable                     | Description |
|--------|------------------------------------------|-------------|
| GitHub | `BLAKEY_TEST_SOURCE_GITHUB_ACCESS_TOKEN` | The test personal access token from GitHub used for requests in the test environment. Default value: `fake_github_access_token` |

To test the project, you can bundle gems and then run the specs:
```
bundle
rake
```

Or if you want to replicate the TravisCI setup and run across many Ruby versions (recommended) then you can use [wwtd](https://github.com/grosser/wwtd):
```
gem install wwtd
wwtd
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/calvinhughes/blakey.

