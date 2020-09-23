module MercadolibreApi
  class RefreshTokenJob < ApplicationJob
    def perform
      client_with_latest_credentials = MercadolibreApi::ClientFactory.build_client_from_config
      client_with_latest_credentials.refresh_and_persist_token!
    end
  end
end
