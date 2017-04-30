module TweetToToot
  class TwitterClient
    attr_accessor :last_tweet, :saved_tweets_file

    def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
      @saved_tweets_file = ".saved_tweets"
      @last_tweet        = load_last_tweets

      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = consumer_key
        config.consumer_secret     = consumer_secret
        config.access_token        = access_token
        config.access_token_secret = access_token_secret
      end
    end

    def tweets_for(handle)
      tweets = @client.user_timeline(handle, options_for(handle))

      save_most_recent(tweets, handle)

      tweets
    end

    def save_last_tweets
      File.open(saved_tweets_file, "w") do |f|
        last_tweet.each do |handle, tweet_id|
          f.puts "#{handle} #{tweet_id}"
        end
      end
    end

    private

    def load_last_tweets
      tweets = {}

      if File.file?(saved_tweets_file)
        File.readlines(saved_tweets_file).each do |line|
          handle, id = line.split(" ")
          tweets[handle] = id
        end
      end

      tweets
    end

    def options_for(handle)
      if !last_tweet[handle].nil?
        { since_id: last_tweet[handle] }
      else
        {}
      end
    end

    def save_most_recent(tweets, handle)
      if tweets.any?
        last_tweet[handle] = tweets.sort { |tweet1, tweet2| tweet1.id <=> tweet2.id }.last.id
      end
    end

    def last_tweet_for(handle)
      last_tweet[handle]
    end
  end
end
