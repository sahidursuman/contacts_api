# ContactsApi


## Installation

Follow Below Steps

    $ git clone git@github.com:sahidursuman/contacts_api.git
    $ cd contacts_api
    $ rvm use ruby-2.7.1@contacts_api --create
    $ echo 'contacts_api' >> .ruby-gemset
    $ cp config/database.example.yml config/database.yml
    $ bundle install
    $ yarn install
    $ rails db:create
    $ rails db:migrate
    $ rails db:seed
    $ rails server -p 3001