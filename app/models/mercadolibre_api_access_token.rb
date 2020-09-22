class MercadolibreApiAccessToken < ApplicationRecord
  # Encryption provided by the lockbox gem
  # @see https://github.com/ankane/lockbox
  # - The encryption is sensitive to changes in the table and attribute names. See lockbox's readme for steps to
  #   change them
  # - Lockbox provides easy key rotation, see readme for more info
  encrypts :access_token, :refresh_token

  validates :access_token, :refresh_token, :expires_at, presence: true

  def self.get_latest_unexpired_access_token!
    latest_token = order(expires_at: :desc).first
    raise AllTokensExpired unless latest_token.expires_at > Time.now

    latest_token.access_token
  end

  class AllTokensExpired < StandardError; end
end
