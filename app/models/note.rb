class Note < ApplicationRecord
  belongs_to :buy_process
  belongs_to :author, class_name: User, foreign_key: :user_id
end
