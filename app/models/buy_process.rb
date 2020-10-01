class BuyProcess < ApplicationRecord
  # Associations
  # ========================
  belongs_to :user, optional: true
  belongs_to :client
  has_many :buy_process_inquiries
  has_many :car_interests
  has_many :notes
  has_many :car_interest_inquiries, through: :car_interests

  # Scope
  # ========================
  scope :with_salesperson, -> { where.not(user_id: nil) }
  scope :client_id_is, -> (client_id) { where(client_id: client_id) }

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
    last_salesperson_id = BuyProcess.with_salesperson.last.user_id

    if active_salespeople_ids.include?(last_salesperson_id)
      active_salespeople_cycle = active_salespeople_ids.cycle(2).to_a # => [1, 3, 4, 1, 3, 4]
      position_of_current_salesperson = active_salespeople_cycle.index(last_salesperson_id)
      id_of_next_salesperson = active_salespeople_cycle[position_of_current_salesperson + 1]
    else
      id_of_next_salesperson = active_salespeople_ids.sample
    end

    User.find(id_of_next_salesperson)
  end
  private_class_method :next_salesperson

  def self.determine_salesperson(client)
    # si el cliente ya tiene un buy process pasado con un vendedor activo? => asigne el mismo vendedor a un nuevo buy process
    last_previous_buy_process_for_client = BuyProcess.client_id_is(client.id).joins(:user).merge(User.active_salespeople).last
    if last_previous_buy_process_for_client.present?
      return last_previous_buy_process_for_client.user
    end
    # Si no => Asigne el siguiente vendedor en la cola a un nuevo buy process
    next_salesperson
  end


  # Instance methods
  # ========================
  def has_salesperson?
    user_id.present?
  end

end
