class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  # ========================
  validates :name, presence: true

  # Associations
  # ========================
  has_many :clients

  # Scope
  # ========================
  # TODO: when roles are implemented, update this scope.
  scope :active_salespeople, -> { active.all }

  # TODO: when we figure out how to deactivate people, modify this
  scope :active, -> { all }

  # Class Methods
  # ========================
  def self.get_random_salesperson
    active_salespeople.order("RANDOM()").first
  end

end
