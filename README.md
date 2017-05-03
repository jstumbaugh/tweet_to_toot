# tweet\_to\_toot

A tool for tooting tweets from your favorite accounts

## Follow us at [@rubydev@octodon.social](https://octodon.social/@rubydev)

Currently, we are following [@RubyInside](https://twitter.com/RubyInside) and
[@rubyflow](https://twitter.com/rubyflow) from Twitter, but are open to more
useful Ruby Development News accounts! Open an issue to suggest a new account!

## Steps to install

### 1. Clone the Repository

```
git clone https://github.com/jstumbaugh/tweet-to-toot
```

### 2. Create a Twitter app to get the access keys

Create a [twitter app](https://apps.twitter.com/app/new) and generate access
tokens. Store these in the `env.example` file.

### 3. Create a Mastodon Account to post the Tweets to

Store the instance URL, login email, and password in the `env.example` file.

### 4. Pick the Twitter Accounts to follow and post to Mastodon

Store these account handles in the `env.example` file.

```env
# Twitter handles in a comma separated list
TWITTER_HANDLES_TO_TOOT='RubyInside, rubyflow'
```

### Pro Tip: Add hashtags to tie all of your toots together

Store your hashtags to add in the `env.example` file. These will be appended to
the end of the tweets and posted to Mastodon.

```env
# Hashtags to be appended to the Toots
HASHTAGS='#RubyDevNews #TweetToToot'
```

### 5. Run the task to toot tweets

You can run the rake task

```
bundle exec rake
```

which will loop forever, or you can spin up a Docker image with:

```
make
```

which builds a docker image, starts it, and begins Tooting!

## Enjoy!
