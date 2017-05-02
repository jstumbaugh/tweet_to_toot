FROM ruby:2.2.4

RUN mkdir /tweet_to_toot

WORKDIR /tweet_to_toot

ADD env_example /tweet_to_toot/.env
ADD Gemfile /tweet_to_toot/Gemfile
ADD Gemfile.lock /tweet_to_toot/Gemfile.lock

# Install the dependencies
RUN bundle install

ADD . /tweet_to_toot

CMD bundle exec rake
