FROM ruby:2.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && \
    apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && \
    apt-get install -y zip unzip --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install

COPY install_extjs.rb /usr/src/app/
RUN /usr/src/app/install_extjs.rb

COPY install_famfamfam.rb /usr/src/app/
RUN /usr/src/app/install_famfamfam.rb

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
