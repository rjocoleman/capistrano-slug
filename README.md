# Capistrano-Slug

[![Gem Version](https://badge.fury.io/rb/capistrano-slug.svg)](http://badge.fury.io/rb/capistrano-slug)

Basically after a deploy is completed Capistrano packs up it's directory and sends it off for artifact deployment sometime else.

The initial use case is taking a point-in-time snapshot of Capistrano deployment, after every deployment, to use on newly bootstrapped servers.
When a new server bootstraps I want it to have the current code (and config etc) that was deployed by Capistrano. This is achieved downloading and 'installing' the slug on boot of a new server.

This enables things like automatic provisioning of new servers but still allows for Capistrano deployments.

Slug work happens on a single server only - the primary of the configured role (default `:all`).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.2.0'
gem 'capistrano-slug'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install capistrano-slug`


## Usage

Require the module in your `Capfile`:

```ruby
require 'capistrano/slug'
```

`capistrano-slug` comes with 4 tasks:

* `slug`
* `slug:create`
* `slug:upload`
* `slug:clean`


#### slug

Create a slug and upload it to your configured storage.

```shell
$ cap production slug
 INFO Some stuff
```

Can be used during a deploy; if you want to create/upload a slug on every deploy:

```ruby
# add to config/deploy.rb

after 'deploy:finished', :slug
```


#### slug:create

Creates a slug:

```shell
$ cap staging slug:create
 INFO Created Slug: foo-application-slug.tar.gz
```


#### slug:upload

Uploads a slug to your configured storage:

```shell
$ cap staging slug:upload
 INFO Uploaded Slug: foo-application-slug.tar.gz
```

#### slug:clean

Removes a slug from your server (not it's storage):

```shell
$ cap staging slug:clean
 INFO Cleaned Slug: foo-application-slug.tar.gz
```



### Configuration

Configurable options, shown here with defaults:

```ruby
set :slug_role, :all
set :slug_name, -> { fetch(:application) }
set :slug_storage_backend, 's3'
set :slug_s3_bucket, nil
```


### Storage

Currently only Amazon S3 is supported. Adding new storage backends shouldn't be a major task, I just haven't had the need -
look at `./lib/capistrano/tasks/storage.rake` and send a PR if you're interested!

#### Amazon S3

An existing S3 bucket is required.

Credentials are not set anywhere in Capistrano, it's assumed you're using IAM instance profiles or have ENV vars set for credentials - if this isn't the case create an issue or send a PR!

The following configuration is required and must be set:

```ruby
set :slug_s3_bucket, 'foo-slug-bucket'
```

Object uploads are set to the `:private` ACL and uploaded with server side encryption - they're not configurable I think these are sane options for this use case.

It currently relies on the `aws` cli being installed on the server: https://aws.amazon.com/cli/


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
