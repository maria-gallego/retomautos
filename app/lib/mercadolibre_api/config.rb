# Holds the configuration for our mercadolibre api component
module MercadolibreApi
  module Config
    mattr_accessor :app_id
    mattr_accessor :app_secret

    # Determines which type of client should be returned by the client factory
    mattr_reader :client_type
    def self.client_type=(type)
      raise MercadolibreApi::ClientFactory::InvalidClientType.new(type) unless MercadolibreApi::ClientFactory::CLIENT_TYPES.include?(type)
      @@client_type = type
    end

    # Allows the configuration of gem using
    # block syntax
    # @example
    #   MercadolibreApi.configure do |config|
    #     config.client_type = :live
    #   end
    def self.configure
      yield self
    end
  end
end
