# Balance API
###### RUBY ON RAILS | POSTGRESQL

## About

<!-- TODO: Add project description/intro -->

Coming soon!

---

## Getting Started

#### Install Prerequisites
This project currently runs on Ruby **version 2.5.0**, tracked in `.ruby-version`. We recommend using [rbenv](https://github.com/rbenv/rbenv) with its plugin [ruby-build](https://github.com/rbenv/ruby-build) to install and manage your Ruby version. You may choose to use `rvm` or another Ruby version manager instead, but we prefer `rbenv` for its featherweight simplicity (read more about why [here](https://github.com/rbenv/rbenv/wiki/Why-rbenv%3F)).

To install and set up Ruby and `rbenv`, follow these [setup instructions](https://gorails.com/setup/).

Once you have `rbenv` set up, install the appropriate version of Ruby.

```
➜  ~ rbenv install 2.5.0
```

If definition 2.5.0 is not found, you may have to update `ruby-build`.

Clone the repository and move to the new repo's directory on your machine. Use `bundler` to install the project's package dependencies with the right versions.

```
➜  ~ gem install bundler
➜  ~ bundle install
```

#### Create the Database

Next, create, migrate, and seed the database. Balance uses `postgresql` as its database of choice, so be sure to first install postgres for your OS and make sure its service is running if you have not already done so before proceeding.
```
➜  ~ bundle exec rake db:create
➜  ~ bundle exec rake db:migrate
```

Migrating your database will overwrite `schema.rb` with an identical file that uses double quotes instead of single quotes. To automatically fix this file, run a pass with the project's Ruby linter [rubocop](https://github.com/rubocop-hq/rubocop).
```
➜  ~ bundle exec rubocop -a
```

#### Verify it Works

Verify that everything is working by starting the rails server and, while the server is running, making a request in a separate terminal window.

```
➜  ~ bundle exec rails s
-------------------------------------------------
➜  ~ curl -G http://localhost:3000/api/v0/users
[]
```

Congrats! You can now develop on the soon-to-be best budget-keeping API out there!!!!!!


---

## Testing

<!-- TODO: Set up tests with rspec -->

---

## Making this Project

```
➜  ~ ruby -v
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-linux]
➜  ~ rbenv version
2.5.0 (set by /home/krockwell/.rbenv/version)
➜  ~ rails -v
Rails 5.1.6
```

Create the rails API app with `postgres` for the database.
```
rails new balance --api --database=postgresql -T --skip-test --no-rdoc --no-ri
```
The `-T --skip-test` flags exclude TestUnit, the default testing framework. This will leave room for us to use `rspec`. The other flags skip generating RDoc/RI documentation.

Install [pgweb](https://github.com/sosedoff/pgweb) using the manual installation instructions for linux [here](https://github.com/sosedoff/pgweb/wiki/Installation), using `/usr/bin/pgweb` instead of `/usr/bin/local/pgweb` and `sudo` if necessary.
```
➜  ~ curl -s https://api.github.com/repos/sosedoff/pgweb/releases/latest \
| grep linux_amd64.zip \
| grep download \
| cut -d '"' -f 4 \
| wget -qi - \
&& unzip pgweb_linux_amd64.zip \
&& rm pgweb_linux_amd64.zip \
&& sudo mv pgweb_linux_amd64 /usr/bin/pgweb
```

Install [solargraph](https://github.com/castwide/solargraph) to use with VSCode [extension](https://github.com/castwide/vscode-solargraph) (it will install [rubocop](https://github.com/rubocop-hq/rubocop) as a dependency, huzzah!).
```
➜  ~ gem install solargraph
```

Scaffold the resources. Column/attribute types are documented under `add_column` in the [Active Record API](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_column).
```
➜  ~ rails g scaffold <ModelName> <attribute>:<type> ...
```

Use `references` to generate and [index](https://stackoverflow.com/questions/7861971/generate-model-using-userreferences-vs-user-idinteger) columns with foreign ids.
```
➜  ~ rails g scaffold <ModelWithReference> <reference_model>:references ...
```

Add relationships between the resource models on each `model_name.rb` file generated. Use `has_many through:` instead of `has_and_belongs_to` in case we want to store more information about the relationship later (see [here](https://stackoverflow.com/questions/2780798/has-and-belongs-to-many-vs-has-many-through) for more).
```
   class ModelName < ApplicationRecord
      has_many :other_models
      belongs_to :another_model
      has_many :fourth_models, through: :join_models
   end
```

To make a self-referential resource, add the foreign key after the table it references has been created, i.e. outside the `create_table` block, and see the tips [here](https://tamouse.github.io/swaac/rails/2015/12/15/self-referential-models-categories/).

Check if a resource name is properly inflected for its singular and plural versions with `"model".pluralize()` and `"models".singularize()`. For custom naming inflections, follow the instructions [here](https://stackoverflow.com/questions/3517989/ruby-on-rails-how-do-you-explicitly-define-plural-names-and-singular-names-in-r).

We can now create the postgresql database and migrate using `rake db:create` and `rake db:migrate`. If encoding is incompatible with the template database, recreate the template with the appropriate encoding by following [these instructions](https://stackoverflow.com/questions/16736891/pgerror-error-new-encoding-utf8-is-incompatible).

Contain endpoint routes within an "api", versioned namespace by adding to `routes.rb`.
```
Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :models
      ...
    end
  end
end
```

Adapt all generated controllers to abide by versioning scheme by moving them to `/api/v0` and containing them in an `Api::V0` module.
```
module Api::V0
  class ModelsController < ApplicationController
    def index
      ...
    end
  end
end
```

We should now be able to restart the rails server and request an endpoint, although there shouldn't be any data in the response yet.
```
➜  ~ curl -G http://localhost:3000/api/v0/models
[]
```

Now is a good time to connect to our remote repository on Github, commit our changes, and push.
```
➜  ~ git remote add origin <https://github.com/path/to/repo.git>
➜  ~ git add -A
➜  ~ git commit -m "initial commit..."
...
➜  ~ git push --set-upstream origin master
```

---

## Changelog

View recent changes [here](https://github.com/courier-new/balance-api/blob/master/CHANGELOG.md).

---

## License

This project and its source code are licensed under the MIT license. See [here](https://github.com/courier-new/balance-api/blob/master/LICENSE) for additional details.

Made with ♥ by Kelli Rockwell [@courier-new](https://github.com/courier-new/balance-api/tree/master).