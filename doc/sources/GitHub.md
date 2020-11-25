# GitHub
Fetches files and repository statistics via the GitHub API using the [`octokit.rb`](https://github.com/octokit/octokit.rb) library.

## Configuration options

|Configuration option|Description|
|----------------------|-------------|
|access_token|Personal access token from your GitHub account that can be generated [here](https://github.com/settings/tokens). Can also be specified by setting the `BLAKEY_SOURCE_GITHUB_ACCESS_TOKEN` environment variable|
|repo_path|The full path to the repository on GitHub that you want to query. Example: `calvinhughes/blakey`|

## Example usage

#### Build source object
```ruby
github_source = Blakey::Source::GitHub.new(access_token: 'personal_access_token', repo_path: 'calvinhughes/blakey')
```

#### Read a file from the repository
This fetches a file via the GitHub API and returns the contents. In the case of a non-existant file, `Blakey::Source::FileNotFound` will be raised.

```ruby
github_source.read_file('doc/some_doc.md')
# => "a file!"
```

#### Fetch repository overview
Returns a hash with useful repository data from the GitHub API.

```ruby
github_source.repository_overview
# => {
#   :open_issues_count=>143, # count of open issues
#   :language=>"Ruby", # configured language of the repo
#   :visibility=>"private", # visibility of the repo
#   :url=>"https://github.com/calvinhughes/blakey", # url of the repo
#   :updated_at=>2020-11-20 13:43:54 UTC, # when it was last updated
#   :created_at=>2012-03-16 09:14:34 UTC, # when it was created
#   :last_pushed_at=>2020-11-20 14:01:40 UTC, # when it was last pushed to
# }
```
