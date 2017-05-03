require 'dotenv/tasks'
require_relative './lib/tweet_to_toot'

task :default => [:authorize, :run]

task :authorize do
  puts "Authorizing Application with Mastodon"
  TweetToToot::MastodonClient.new(ENV["MASTODON_INSTANCE_URL"])
end

task run: :dotenv do
  mastodon = TweetToToot::MastodonClient.new(ENV["MASTODON_INSTANCE_URL"])
  twitter  = TweetToToot::TwitterClient.new(ENV["TWITTER_CONSUMER_KEY"],
                                            ENV["TWITTER_CONSUMER_SECRET"],
                                            ENV["TWITTER_ACCESS_TOKEN"],
                                            ENV["TWITTER_ACCESS_TOKEN_SECRET"])
  runner = TweetToToot::Runner.new(mastodon, twitter)
  runner.run
end
