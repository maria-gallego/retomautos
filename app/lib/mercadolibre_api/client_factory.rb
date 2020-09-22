# A factory that builds MercadolibreApi clients following the configuration
# given at initialize time.
#
# The intended usage of this class is through .build_client_from_config
#   Build a client for a specific access_token
#     MercadolibreApi::Config.client_factory.build(access_token: 'a-token')
#   When we want to resolve the access_token automatically
#     MercadolibreApi::Config.client_factory.build
module MercadolibreApi
  class ClientFactory
    CLIENT_TYPES = [:live, :dummy]

    # Builds a client using from the configuration set when the app is booted and
    # stored in MercadolibreApi::Config
    # @return [MercadolibreApi::LiveClient, MercadolibreApi::DummyClient]
    def self.build_client_from_config(config: MercadolibreApi::Config)
      new(
        client_type: config.client_type,
        app_id: config.app_id,
        app_secret: config.app_secret
      ).build
    end

    def initialize(client_type:, app_id:, app_secret:, access_token_repo: MercadolibreApiAccessToken)
      @client_type = client_type
      @app_id = app_id
      @app_secret = app_secret
      @access_token_repo = access_token_repo
    end

    # @param access_token [String, nil] nil to let the factory resolve the access_token automatically
    # @return [MercadolibreApi::LiveClient, MercadolibreApi::DummyClient]
    def build(access_token: nil)
      case client_type
      when :live
        build_live_client(access_token)
      when :dummy
        build_dummy_client
      else
        raise InvalidClientType.new(client_type)
      end
    end

    class InvalidClientType < StandardError
      def initialize(attempted_type)
        msg = "#{attempted_type} is not a valid type. The valid types are #{CLIENT_TYPES}"
        super(msg)
      end
    end

    private

    attr_reader :access_token_repo, :client_type, :app_id, :app_secret

    def build_live_client(access_token)
      access_token = access_token_repo.get_latest_unexpired_access_token! unless access_token
      MercadolibreApi::LiveClient.new(
        access_token: access_token,
        app_id: app_id,
        app_secret: app_secret)
    end

    def build_dummy_client
       MercadolibreApi::DummyClient.new
    end
  end
end
