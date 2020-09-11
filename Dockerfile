FROM ruby:2.5.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs \
                       imagemagick
                       
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /webapp
WORKDIR /webapp

ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

ADD . /webapp

RUN mkdir -p tmp/sockets

RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile \
 && yarn cache clean \
 && rm -rf node_modules tmp/cache
