class BuyProcess < ApplicationRecord
  # Associations
  # ========================
  belongs_to :user, optional: true
  belongs_to :client
  has_many :buy_process_inquiries, dependent: :destroy
  has_many :car_interests, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :car_interest_inquiries, through: :car_interests
  has_many :car_intakes, through: :car_interests
  # If a single buy process results in multiple cars being sold, our current recommendation is to
  # create multiple buy processes
  has_one :car_sale

  # Scope
  # ========================
  scope :with_salesperson, -> { where.not(user_id: nil) }
  scope :client_id_is, -> (client_id) { where(client_id: client_id) }
  scope :user_id_is, -> (user_id) { where(user_id: user_id) }
  scope :currently_open, -> { left_outer_joins(:car_sale).where(car_sales: { id: nil }, unsuccessfully_closed_at: nil) }
  scope :created_at_date_from, -> date { where('buy_processes.created_at >= ?', date.to_date.beginning_of_day) }
  scope :created_at_date_to, -> date { where('buy_processes.created_at <= ?', date.to_date.end_of_day) }
  scope :without_notes, -> { select('buy_processes.*,  count(notes.id) as notes_count').left_outer_joins(:notes).group('buy_processes.id').having('count(notes.id) = 0') }
  scope :successfully_closed_processes, -> { joins(:car_sale) }
  scope :unsuccessfully_closed_processes, -> { where.not(unsuccessfully_closed_at: nil) }
  scope :successfully_closed_at_date_from, -> date { joins(:car_sale).merge(CarSale.sold_at_date_from(date)) }
  scope :successfully_closed_at_date_to, -> date { joins(:car_sale).merge(CarSale.sold_at_date_to(date)) }
  scope :unsuccessfully_closed_at_date_from, -> date { where('buy_processes.unsuccessfully_closed_at >= ?', date.to_date.beginning_of_day) }
  scope :unsuccessfully_closed_at_date_to, -> date { where('buy_processes.unsuccessfully_closed_at <= ?', date.to_date.end_of_day) }

  # Buy process is often left_outer_joined with other tables. When that happens, Rails interprets joins(:client)
  # as a LEFT OUTER JOIN as well. That is wrong, so we need to explicitly define an inner join to clients
  scope :inner_joins_client, -> { joins('INNER JOIN clients ON buy_processes.client_id = clients.id') }
  scope :client_name_contains, -> name { inner_joins_client.merge(Client.client_name_contains(name)) }
  scope :client_email_contains, -> email { inner_joins_client.merge(Client.client_email_contains(email)) }

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
    last_assigned_buy_process = BuyProcess.with_salesperson.last
    # Edge case: no previous buy processes
    return User.first if !last_assigned_buy_process.present?

    active_salespeople_ids = User.active_salespeople.pluck(:id)
    last_salesperson_id = last_assigned_buy_process.user_id
    # Edge case: previous buy process with deactivated salesperson
    return User.find(active_salespeople_ids.sample) unless active_salespeople_ids.include?(last_salesperson_id)

    active_salespeople_cycle = active_salespeople_ids.cycle(2).to_a # => [1, 3, 4, 1, 3, 4]
    position_of_current_salesperson = active_salespeople_cycle.index(last_salesperson_id)
    id_of_next_salesperson = active_salespeople_cycle[position_of_current_salesperson + 1]
    User.find(id_of_next_salesperson)
  end

  private_class_method :next_salesperson

  def self.determine_salesperson(client)
    # si el cliente ya tiene un buy process pasado con un vendedor activo? => asigne el mismo vendedor a un nuevo buy process
    last_previous_buy_process_for_client = BuyProcess.client_id_is(client.id).joins(:user).merge(User.active_salespeople).last
    return last_previous_buy_process_for_client.user if last_previous_buy_process_for_client.present?

    # Si no => Asigne el siguiente vendedor en la cola a un nuevo buy process
    next_salesperson
  end

  def self.find_open_or_create_for_client!(client, source)
    last_previous_open_buy_process_for_client = BuyProcess.currently_open.client_id_is(client.id).last
    return last_previous_open_buy_process_for_client if last_previous_open_buy_process_for_client.present?

    create!(source: source, client: client)
  end

  def self.next_active_process_with_same_salesperson(current_buy_process)
    return nil if !current_buy_process.active?
    active_processes_for_current_user = BuyProcess.currently_open
                                                  .user_id_is(current_buy_process.user_id)
                                                  .order(created_at: :asc).pluck(:id)
    position_of_current_buy_process = active_processes_for_current_user.index(current_buy_process.id)
    position_of_next_buy_process = position_of_current_buy_process + 1
    next_buy_process_id = active_processes_for_current_user[position_of_next_buy_process]
    return nil if next_buy_process_id.nil?

    BuyProcess.find(next_buy_process_id)
  end

  def self.previous_active_process_with_same_salesperson(current_buy_process)
    return nil if !current_buy_process.active?
    active_processes_for_current_user = BuyProcess.currently_open
                                                  .user_id_is(current_buy_process.user_id)
                                                  .order(created_at: :asc).pluck(:id)
    position_of_current_buy_process = active_processes_for_current_user.index(current_buy_process.id)
    position_of_next_buy_process = position_of_current_buy_process - 1
    previous_buy_process_id = active_processes_for_current_user[position_of_next_buy_process]
    return nil if position_of_current_buy_process == 0

    BuyProcess.find(previous_buy_process_id)
  end

  def self.next_active_process(current_buy_process)
    return nil if !current_buy_process.active?
    active_processes = BuyProcess.currently_open.order(created_at: :asc).pluck(:id)
    position_of_current_buy_process = active_processes.index(current_buy_process.id)
    position_of_next_buy_process = position_of_current_buy_process + 1
    next_buy_process_id = active_processes[position_of_next_buy_process]
    return nil if next_buy_process_id.nil?

    BuyProcess.find(next_buy_process_id)
  end

  def self.previous_active_process(current_buy_process)
    return nil if !current_buy_process.active?
    active_processes = BuyProcess.currently_open.order(created_at: :asc).pluck(:id)
    position_of_current_buy_process = active_processes.index(current_buy_process.id)
    position_of_next_buy_process = position_of_current_buy_process - 1
    previous_buy_process_id = active_processes[position_of_next_buy_process]
    return nil if position_of_current_buy_process == 0

    BuyProcess.find(previous_buy_process_id)
  end

  # Instance methods
  # ========================
  def has_salesperson?
    user_id.present?
  end

  def assign_sales_person_if_non_existent!
    assigned_salesperson = BuyProcess.determine_salesperson(client)
    # Covers 2 cases:
    # - buy_process does not have a sales person assigned
    # - the sales person has to assign has change according to determine_salesperson (e.g. resigned salesperson)
    update!(user: assigned_salesperson) if self.user_id != assigned_salesperson.id
  end

  def active?
    !successfully_closed? && !unsuccessfully_closed?
  end

  def successfully_closed?
    # car_sale may be associated with the buy process in memory (not persisted)
    # if this happens, the buy process should not be considered successfully_closed
    CarSale.exists?(buy_process_id: self.id)
  end

  def unsuccessfully_closed?
    unsuccessfully_closed_at.present?
  end

  def successfully_closed_at
    car_sale.created_at
  end
end
