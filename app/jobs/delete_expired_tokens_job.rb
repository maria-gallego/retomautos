class DeleteExpiredTokensJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "Starting deletion of expired tokens"
    record_deleted_num = MercadolibreApiAccessToken.delete_expired_tokens
    Rails.logger.info "Finished deleting #{record_deleted_num} expired tokens"
  end
end
