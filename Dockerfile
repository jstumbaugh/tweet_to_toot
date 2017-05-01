FROM ruby:2.2.4

RUN mkdir /home/tweet_to_toot

WORKDIR /home/tweet_to_toot

# link the example env
RUN ln -s env.example .env

ADD Gemfile /home/tweet_to_toot/Gemfile
ADD Gemfile.lock /home/tweet_to_toot/Gemfile.lock

# Install the dependencies
RUN bundle install

ADD . /home/tweet_to_toot
