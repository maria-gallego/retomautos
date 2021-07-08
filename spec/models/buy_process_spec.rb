describe 'BuyProcess' do
  let!(:salesperson_1) { BuyProcess.create!(user_id: 1,client_id: 1, created_at: Time.now - 2.days ) }
  context 'scopes' do
    let!(:buy_process) { BuyProcess.create!(client_id: 1, created_at: Date.today - 8.days, updated_at: Date.today - 8.days )}

    describe ".with salesperson" do
      context "has a salesperson" do

      end

      context "does not have a salesperson" do

      end
    end
  end
end