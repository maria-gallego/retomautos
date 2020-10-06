class Role < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :display_name, presence: true, uniqueness: true

end
