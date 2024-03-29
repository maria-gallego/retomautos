class MercadolibreApiAccessToken < ApplicationRecord
  # Encryption provided by the lockbox gem
  # @see https://github.com/ankane/lockbox
  # - The encryption is sensitive to changes in the table and attribute names. See lockbox's readme for steps to
  #   change them
  # - Lockbox provides easy key rotation, see readme for more info
  encrypts :access_token, :refresh_token

  validates :access_token, :refresh_token, :expires_at, presence: true

  def self.get_latest_unexpired_access_and_refresh_tokens!
    # FIXME: change code and tests to return the access_token that expires the latest and the refresh_token
    #   that was created the latest (they may not be in the same row of the DB)
    latest_token = order(expires_at: :desc).first
    raise AllTokensExpired if latest_token.nil? || latest_token.expires_at < Time.now

    [latest_token.access_token, latest_token.refresh_token]
  end

  def self.persist_new_credentials!(access_token:, refresh_token:, expires_at:)
    create!(access_token: access_token, refresh_token: refresh_token, expires_at: expires_at)
  end

  def self.delete_expired_tokens
    all.where('expires_at <= ?', Time.now ).delete_all
  end

  class AllTokensExpired < StandardError; end
end
