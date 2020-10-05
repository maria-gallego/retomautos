class AddTuCarroQuestionIdToCarInterestInquiry < ActiveRecord::Migration[6.0]
  def change
    add_column :car_interest_inquiries, :tu_carro_question_id, :string
    add_index :car_interest_inquiries, :tu_carro_question_id
  end
end
