# Developer Setup

1. use rvm
1. allow the .rvmrc file
1. `gem install bundler`
1. `bundle`
1. `rake db:create db:migrate db:seed`
1. Download extJS 4.1 (http://www.sencha.com/products/extjs), unzip, and place where ever you like.
1. Link to your extJS folder path under `public/extjs`: (From app root) `ln -s /MY/PATH/extjs/ public/extjs`
1. `rails s`

# Optional
 Add icons
 
1. Download icons from http://www.famfamfam.com/lab/icons/silk/
1. Link to the icons under `public/images/icons`: (From app root) `ln -s /MY/PATH/famfamfam_silk_icons/icons public/images/icons` 


## Mailcatcher

Use mailcatcher to see what emails look like in development.
Follow the instructions from http://mailcatcher.me/ to create an rvm wrapper so you don't install it all over your gemsets

# License
Velocipede is released under the MIT license (http://opensource.org/licenses/MIT)
