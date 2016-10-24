## Installation

1. Add to Gemfile

        gem 'gcms', git: 'git@github.com:ktp09305/gcms.git'


2. Setup database.yml (only PostgreSQL 9.2+ supported)

3. Run generator:

        rails g gcms:install

4. Copy migrations:

        rake gcms:install:migrations

5. Migrate:

        rake db:migrate

6. Set locale in your main app.

7. Precompile assets (if it will be production app):

        RAILS_ENV=production bundle exec rake assets:precompile

8. Run it using your favorite webserver - unicorn, puma, thin
9. Open your browser at **http://localhost:3000/gcms** and sign up first admin user.
