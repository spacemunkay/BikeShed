# About
A web application for bicycle collectives to track bicycles, bicycle work history, volunteer hours, volunteer work history, and volunteers currently in the shop.

See an overview video of what it looks like and how it works here: https://www.youtube.com/watch?v=0-JjM6d9nK4.

## Instructions/Guides

### Adding a User
To add a user, a user must sign themselves up from the initial login screen.  An admin can later log in to grant that user admin privileges afterward, if desired.

### Adding a Bike
I'll be making a video demonstrating how to add a bike to the system.

## Views
The app has two different views.  One for "core" volunteers which I consider admins, and another for "customer" volunteers which I consider users.  Because of the Netzke/ExtJS framework I used, the current UI is non-intuitive and I feel like is only adequate for admins who can take the time to learn the system.  I'm in the process of designing a simpler mobile friendly UI with the essential functionality that's intended for users.

## Deployment
Currently, at the Velocipede collective we have it running on a computer in the shop on the local network.  The reason for this, is so that it's only accessible from within the shop.  I'm weighing out different methods for ensuring that users can only log in from within the shop (and not from home), such as a shop password that only admins can see and would make visible from within the physical bike shop.  I also don't have to worry about security issues while the app is in development.  In the future, I'd like to see the app hosted much like http://freehub.bikekitchen.org/.

## Ideas
At Velocipede, with a mobile friendly UI for users, I'm hoping we can get donations of old, unused smart phones that can be used as stations to log volunteer work and hours, connected via local wifi.  They can be secured by gluing cables into the earphone jacks to deter theft if necessary.  This might be another way that the collective can promote reuse of materials.

# Developer Setup

1. use rvm
1. allow the .rvmrc file
1. `gem install bundler`
1. `bundle`
1. Install Postgres (Mac OSX instructions below)
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
1. Copy over DB config:  `cp config/database.yml.example config/database.yml`
1. Update config with your database (velocipede), user (velocipede), and password.

# Optional
 Add icons

1. Download icons from http://www.famfamfam.com/lab/icons/silk/
1. Link to the icons under `public/images/icons`: (From app root) `ln -s /MY/PATH/famfamfam_silk_icons/icons public/images/icons`

# License
Velocipede is released under the MIT license (http://opensource.org/licenses/MIT)

<a href="http://madewithloveinbaltimore.org">Made with &hearts; in Baltimore</a>
