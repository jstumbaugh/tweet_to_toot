module TweetToToot
  class Runner
    attr_accessor :handles, :sleep_time, :logger

    def initialize(mastodon, twitter, handles = nil, sleep_time = 3600)
      @mastodon   = mastodon
      @twitter    = twitter
      @handles    = ENV["TWITTER_HANDLES_TO_TOOT"].split(", ")
      @sleep_time = sleep_time
      @logger     = Logger.new(STDOUT)
    end

    def format_message(handle, text)
      "@#{handle}: #{text.gsub(/\n/, " ")}\n#{ENV["HASHTAGS"]}"
    end

    # The main worker method
    def run
      begin
        loop do
          handles.each do |handle|
            @twitter.tweets_for(handle).each do |tweet|
              message = format_message(handle, tweet.text)

              @mastodon.toot(message)

              logger.info "Tooted: #{message.gsub(/\n/, " ")}"
            end
          end

          sleep sleep_time
        end
      rescue Exception
        # Persist the last tweets we tooted
        @twitter.save_last_tweets
        logger.info "Interrupted, saving last tweets..."
      end
    end
  end
end
