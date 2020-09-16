class Client < ApplicationRecord
  # Validations
  # ========================
  validates :name, presence: true
  validates :email,
            format: { with: Devise.email_regexp, message: "email inválido" },
            presence: true,
            uniqueness: true

  # Associations
  # ========================
  belongs_to :user, optional: true
  has_many :inquiries

  # Callback
  # ========================
  before_validation :normalize_email

  # Scope
  # ========================
  scope :with_salesperson, -> { where.not(user_id: nil) }

  # Class Methods
  # ========================
  # Returns the user of the next active salesperson
  # For example,
  #   if active_salespeople_ids = [1,2,4]
  #   and last_salesperson_id = 4
  #   it returns 1
  #
  #   if active_salespeople_ids = [1,2,4]
  #   and last_salesperson_id = 3
  #   it returns a random id from the active_salespeople_ids
  def self.next_salesperson
    active_salespeople_ids = User.active_salespeople.pluck(:id)
    last_salesperson_id = Client.with_salesperson.last.user_id

    if active_salespeople_ids.include?(last_salesperson_id)
      active_salespeople_cycle = active_salespeople_ids.cycle(2).to_a  # => [1, 3, 4, 1, 3, 4]
      position_of_current_salesperson = active_salespeople_cycle.index(last_salesperson_id)
      id_of_next_salesperson =  active_salespeople_cycle[position_of_current_salesperson + 1]
    else
      id_of_next_salesperson = active_salespeople_ids.sample
    end

    User.find(id_of_next_salesperson)
  end

  # Instance methods
  # ========================
  def has_salesperson?
    user_id.present?
  end

  private

  def normalize_email
    self.email = self.email.downcase.strip unless self.email.nil?
  end
end
