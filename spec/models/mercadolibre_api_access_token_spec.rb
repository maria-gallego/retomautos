describe MercadolibreApiAccessToken do

  context "class methods" do
    describe ".delete_expired_tokens" do

      it "deletes only the tokens that have expired" do
        # Setup
        expired_token = MercadolibreApiAccessToken.create!(access_token: "1234", refresh_token: "567", expires_at: Time.now - 1.hours)
        unexpired_token = MercadolibreApiAccessToken.create!(access_token: "abc", refresh_token: "cde", expires_at: Time.now + 6.hours)

        # Execute
        MercadolibreApiAccessToken.delete_expired_tokens

        # Assert / Expect
        expect(MercadolibreApiAccessToken.all.size).to eq(1)
        expect(MercadolibreApiAccessToken.first).to eq unexpired_token
      end


      context "when there are no tokens expired" do
        it "does nothing" do
          # Setup
          unexpired_token = MercadolibreApiAccessToken.create!(access_token: "abc", refresh_token: "cde", expires_at: Time.now + 6.hours)

          # Execute
          MercadolibreApiAccessToken.delete_expired_tokens

          # Assert / Expect
          expect(MercadolibreApiAccessToken.all.size).to eq(1)
          expect(MercadolibreApiAccessToken.first).to eq unexpired_token
        end
      end

    end

    describe ".get_latest_unexpired_access_and_refresh_tokens!" do

      it "gets latest unexpired token" do
        unexpired_token_2 = MercadolibreApiAccessToken.create!(access_token: "unexpired2", refresh_token: "456", expires_at: Time.now + 2.hours)
        expired_token = MercadolibreApiAccessToken.create!(access_token: "expired", refresh_token: "789", expires_at: Time.now - 1.hours)
        unexpired_token = MercadolibreApiAccessToken.create!(access_token: "unexpired1", refresh_token: "123", expires_at: Time.now + 1.hours)

        result = MercadolibreApiAccessToken.get_latest_unexpired_access_and_refresh_tokens!

        expect(result[0]).to eq(unexpired_token_2.access_token)
        expect(result[1]).to eq(unexpired_token_2.refresh_token)
      end

      context "when there are no unexpired tokens" do
        it "raises an error" do
          expired_token = MercadolibreApiAccessToken.create!(access_token: "expired", refresh_token: "789", expires_at: Time.now - 1.hours)
          expect { MercadolibreApiAccessToken.get_latest_unexpired_access_and_refresh_tokens! }.to raise_error(MercadolibreApiAccessToken::AllTokensExpired)
        end

        it "raises an error when there are no tokens in the database" do
          expect { MercadolibreApiAccessToken.get_latest_unexpired_access_and_refresh_tokens! }.to raise_error(MercadolibreApiAccessToken::AllTokensExpired)
        end
      end
    end
  end

  context "instance methods" do
  end
end
