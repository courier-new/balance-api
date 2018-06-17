# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



## How to Make this App

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