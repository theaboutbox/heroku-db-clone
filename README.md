# heroku-db-clone

Backup a Heroku app's database and restore it locally. Defaults to
reading the 'development' section of `config/database.yml` to get
database configuration information.

## Installation

Add this line to your application's Gemfile:

    gem 'heroku_db_clone'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heroku_db_clone

## Usage

`heroku-db-clone [app-name]`

`heroku-db-clone --help` to get a list of options

## To Do

* Reasonable error messages if we cannot find required executables

* Specify username and password to postgres database if we cannot find
it

* Handle multi-file database dumps

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
