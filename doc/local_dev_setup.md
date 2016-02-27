# Local Developer Setup

1. use rvm
1. allow the .rvmrc file
1. `gem install bundler`
1. `bundle`
1. Install Postgres (Mac OSX instructions below)
1. Copy over DB config:  `cp config/database.yml.example config/database.yml`
1. Update config with your database (velocipede), user (velocipede), and password.
1. `rake db:create db:migrate`
1. `rake db:seed`
1. Download extJS 4.1 (A version of 4.1 is hosted here: http://my.jasondenney.com/extjs-4.1.1.zip) Latest versions at http://www.sencha.com/products/extjs. Unzip and place where ever you like.
1. Link to your extJS folder path under `public/extjs`: (From app root) `ln -s /MY/PATH/extjs/ public/extjs`
1. `rails s`


# Postgres 9.2 Mac OSX Install
1. Install homebrew `ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"`
1. `brew install postgres`
1. First time db initialization `initdb /usr/local/var/postgres -E utf8`
1. Start Postgres `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`
1. Create your PG user `createuser -d -P velocipede`
1. Create your database `createdb -U velocipede --owner=velocipede velocipede`
1. Create your test database `createdb -U velocipede --owner=velocipede velocipede_test`

# Testing

1. Install phantomjs `brew install phantomjs`
1. Run tests with `rspec`

# Optional
 Add icons

1. Download icons from http://www.famfamfam.com/lab/icons/silk/
1. Link to the icons under `public/images/icons`: (From app root) `ln -s /MY/PATH/famfamfam_silk_icons/icons public/images/icons`
