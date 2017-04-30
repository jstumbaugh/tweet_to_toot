# tweet-to-toot

A tool for tooting tweets from your favorite accounts

### Steps to install

#### Clone the Repository

```
git clone https://github.com/jstumbaugh/tweet-to-toot
```

#### Create a Twitter app to get the access keys

Create a [twitter app](https://apps.twitter.com/app/new) and generate access
tokens. Store these in the `env.example` file.

#### Create a Mastodon Account to post the Tweets to

Store the instance URL, login email, and password in the `env.example` file.

#### Pick the Twitter Accounts to follow and post to Mastodon

Store these account handles in the `env.example` file.

```env
# Twitter handles in a comma separated list
TWITTER_HANDLES_TO_TOOT='RubyInside, rubyflow'
```

#### Run the task to toot tweets

You can run the rake task `bundle exec rake` that will loop forever, or you can
spin up a Docker image with:

```
docker build --tag "tweet_to_toot" .
```

#### Pro Tip: Add hashtags to tie all of your toots together

Store your hashtags to add in the `env.example` file. These will be appended to
the end of the tweets and posted to Mastodon.

```env
# Hashtags to be appended to the Toots
HASHTAGS='#RubyDevNews #TweetToToot'
```

### Enjoy!
