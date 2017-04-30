FROM ruby:2.4.1-slim

RUN mkdir /tweet_to_toot
WORKDIR /tweet_to_toot
ADD . /tweet_to_toot

# link the example env
RUN ln -s env.example .env

# Install the dependencies
RUN bundle install

# Run the task to post toots
CMD bundle exec rake
