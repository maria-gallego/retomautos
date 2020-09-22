class CreateMercadolibreApiAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :mercadolibre_api_access_tokens do |t|
      t.text :access_token_ciphertext
      t.text :refresh_token_ciphertext
      t.datetime :expires_at

      t.timestamps
    end
  end
end
