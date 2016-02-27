# About
A web application for bicycle collectives to track bicycles, bicycle work history, volunteer hours, volunteer work history, and volunteers currently in the shop.

See an overview video of what the desktop view looks like and how it works here: https://www.youtube.com/watch?v=0-JjM6d9nK4.

## Overview/Instructions/Guides

See [guides](doc/guides.md)

# Developer Setup

## Running with Docker (recommended)

1. These instructions haven't been tested, please provide corrections!
1. Install Docker Toolbox <https://www.docker.com/toolbox>
1. Make sure you have a machine running: `docker-machine start default && eval "$(docker-machine env default)"`
1. Execute `docker-compose build`
1. Execute `docker-compose run web rake db:create db:migrate db:seed`
1. Execute `docker-compose up`
1. If using Docker Toolbox, use `docker-machine ip default` to get the IP where the server is running.
1. Test the Rails server is running with by visiting `<INSERT IP>:8080` in your browser.

### Developer Workflow
The project directory should already be mounted inside the container, so you should be able to make live changes. However, since the project is running in the 'web' container, you need to prepend commands with `docker-compose run web`.

You'll likely want to add the following aliases:
```
alias dm='docker-machine'
alias dc='docker-compose'
alias dcrw='docker-compose run web'
```

That way your commands can be shortened to:
```
dcrw rake routes
dcrw rails console
dcrw rspec
```
If there's a better way, I'm all ears. Alternatively you could ssh into the machine with `dcrw bash`.

# License
Velocipede is released under the MIT license (http://opensource.org/licenses/MIT)

<a href="http://madewithloveinbaltimore.org">Made with &hearts; in Baltimore</a>
