FROM ruby:2.5.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs \
                       imagemagick

RUN mkdir /webapp
WORKDIR /webapp

ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

ADD . /webapp

RUN mkdir -p tmp/sockets

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]