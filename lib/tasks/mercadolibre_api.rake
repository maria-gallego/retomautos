namespace :mercadolibre_api do
  # The api tokens expire every 6 hours so this should be run every 5 hours for safety
  desc "Schedules a job to refresh the mercadolibre api token"
  task :refresh_token => :environment do
    Rails.logger.info "Scheduling MercadolibreApi::RefreshTokenJob"
    MercadolibreApi::RefreshTokenJob.perform_later
    Rails.logger.info "Scheduled MercadolibreApi::RefreshTokenJob"
  end
end
