# About
A web application for bicycle collectives to track bicycles, bicycle work history, volunteer hours, volunteer work history, and volunteers currently in the shop.

See a live demo here: <http://bikeshed.wvcompletestreets.org/>

# Version
  
  - Rails 3.2.18 / Ruby 2.1.1

  - jquery 1.10.1 / bootstrap 3.2.2

# Developer Setup

1.git clone https://github.com/deimos620/bikeshed.git

2.rvm gemset create bikeshed 

3.rvm gemset use ruby-2.1.1@bikeshed

4.bundle install

5.install bootstrap 3.2 to assets and layouts
   
   - rails generate bootstrap:install less
   
   - rails generate bootstrap:layouts

6.Custom database.yml

7.Create Postgresql db
  
  - sudo postgres -p sql

8.start application
  
  - Rails server.


Thanks!
 
 ---- Deimos -----
