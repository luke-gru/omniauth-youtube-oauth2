module OmniAuth
  module Strategies
    class YouTubeOauth2 < GoogleOauth2
      option :name, 'you_tube'
      DEFAULT_SCOPE = "https://gdata.youtube.com"
      class YouTubeOAuth2Error < StandardError; end

      def authorize_params
        super.tap do |params|
          # Read the params if passed directly to omniauth_authorize_path
          %w(scope approval_prompt access_type state hd).each do |k|
            params[k.to_sym] = request.params[k] unless [nil, ''].include?(request.params[k])
          end
          params[:scope] = DEFAULT_SCOPE.split(",").join(' ')
          # This makes sure we get a refresh_token.
          # http://googlecode.blogspot.com/2011/10/upcoming-changes-to-oauth-20-endpoint.html
          params[:access_type] = 'offline' if params[:access_type].nil?
          params[:approval_prompt] = 'force' if params[:approval_prompt].nil?
          # Override the state per request
          session['omniauth.state'] = params[:state] if request.params['state']
        end
      end

      uid { raw_info['username'] }

      info do
        {
          :nickname => raw_info['author']['name'],
          :name => raw_info['author']['name'],
          :first_name => raw_info['firstName'],
          :last_name => raw_info['lastName'],
          :image => raw_info['thumbnail']['url']
        }
      end

      def raw_info
        @raw_info ||= begin
          response = access_token.get("http://gdata.youtube.com/feeds/api/users/default").response
          if response.status / 10 == 20 # success
            xml = response.body
            Hash.from_xml(xml)['entry']
          else
            raise YouTubeOAuth2Error, "no youtube account found"
          end
        end
      end

    end
  end
end
