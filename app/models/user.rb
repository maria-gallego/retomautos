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
  has_many :buy_processes
  has_many :clients, through: :buy_processes
  has_many :notes, through: :buy_processes
  has_many :role_grants
  has_many :roles, through: :role_grants

  # Scope
  # ========================
  scope :active_salespeople, -> { active.joins(:roles).merge(Role.sales) }
  scope :active_admins, -> { active.joins(:roles).merge(Role.admin) }

  # TODO: when we figure out how to deactivate people, modify this
  scope :active, -> { all }

  # Class Methods
  # ========================
  def self.get_random_salesperson
    active_salespeople.order("RANDOM()").first
  end


  def has_role?(role_code)
    roles.where(code: role_code).exists?
    # a_user.roles
    # User.joins(:roles)
  end

end
