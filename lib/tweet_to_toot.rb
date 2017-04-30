require "mastodon"
require "twitter"
require "oauth2"
require "dotenv"

Dotenv.load

require_relative './tweet_to_toot/twitter_client'
require_relative './tweet_to_toot/mastodon_client'
require_relative './tweet_to_toot/runner'

module TweetToToot
end
