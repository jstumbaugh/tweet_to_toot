module TweetToToot
  class MastodonClient
    def initialize(instance_url)
      @instance_url = instance_url
      @client = Mastodon::REST::Client.new(
        base_url:     instance_url,
        bearer_token: mastodon_access_token
      )
    end

    def toot(message)
      @client.create_status(message)
    end

    private

    def mastodon_access_token
      if !ENV["MASTODON_ACCESS_TOKEN"]
        access_token = get_mastodon_access_token

        File.open(".env", "a+") do |f|
          f.write "MASTODON_ACCESS_TOKEN='#{access_token}'\n"
        end
      else
        ENV["MASTODON_ACCESS_TOKEN"]
      end
    end

    # This will only be run the first time
    def get_mastodon_access_token
      Logger.new(STDOUT).info "Mastodon Access Token was not found. Creating a new one now..."
      scopes = 'read write follow'

      client = Mastodon::REST::Client.new(base_url: @instance_url)
      app = client.create_app("tweet-to-toot", "urn:ietf:wg:oauth:2.0:oob", scopes)

      store_client_credentials(app.client_id, app.client_secret)

      oauth_client = OAuth2::Client.new(app.client_id, app.client_secret, site: @instance_url)
      oauth_client.password.get_token(ENV["MASTODON_LOGIN"], ENV["MASTODON_PASSWORD"], scope: scopes).token
    end

    def store_client_credentials(client_id, client_secret)
      File.open(".env", "a+") do |f|
        f.puts "MASTODON_CLIENT_ID='#{client_id}'"
        f.puts "MASTODON_CLIENT_SECRET='#{client_secret}'"
      end
    end
  end
end
