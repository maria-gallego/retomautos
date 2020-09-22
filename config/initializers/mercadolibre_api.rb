# To prepare block added to fix a deprecation warning about loading
# autoloaded constants during initialization
# @see https://stackoverflow.com/a/59971682/4304753
Rails.configuration.to_prepare do
  MercadolibreApi::Config.configure do |config|
    if ENV["MERCADOLIBRE_API_CLIENT_TYPE"].present?
      client_type = ENV["MERCADOLIBRE_API_CLIENT_TYPE"].to_sym
      config.client_type = client_type

      puts "MERCADOLIBRE_API_CLIENT_TYPE ENV detected"
      puts "Setting MercadolibreApi client_type to: #{client_type}"
      puts "*" * 30
    else
      config.client_type = Rails.env.production? ? :live : :dummy
    end
    config.app_id = Rails.application.credentials.mercadolibre_app_id
    config.app_secret = Rails.application.credentials.mercadolibre_app_secret
  end
end
