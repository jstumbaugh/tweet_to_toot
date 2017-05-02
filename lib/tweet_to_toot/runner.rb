module TweetToToot
  class Runner
    attr_accessor :handles, :sleep_time
    def initialize(mastodon, twitter, handles = nil, sleep_time = 60)
      @mastodon   = mastodon
      @twitter    = twitter
      @handles    = ENV["TWITTER_HANDLES_TO_TOOT"].split(", ")
      @sleep_time = sleep_time
    end

    def format_message(handle, text)
      "@#{handle}: #{text} #{ENV["HASHTAGS"]}"
    end

    # The main worker method
    def run
      begin
        loop do
          handles.each do |handle|
            @twitter.tweets_for(handle).each do |tweet|
              message = format_message(handle, tweet.text)

              @mastodon.toot(message)

              puts "Tooted @#{handle}: #{message}"
            end
          end

          sleep sleep_time
        end
      rescue SystemExit, Interrupt
        # Persist the last tweets we tooted
        @twitter.save_last_tweets
      end
    end
  end
end
