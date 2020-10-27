class BuyProcess < ApplicationRecord
  # Associations
  # ========================
  belongs_to :user, optional: true
  belongs_to :client
  has_many :buy_process_inquiries
  has_many :car_interests
  has_many :notes
  has_many :car_interest_inquiries, through: :car_interests
  has_many :cars, through: :car_interests

  # Scope
  # ========================
  scope :with_salesperson, -> { where.not(user_id: nil) }
  scope :client_id_is, -> (client_id) { where(client_id: client_id) }
  scope :user_id_is, -> (user_id) { where(user_id: user_id) }
  scope :currently_open, -> { where(successfully_closed_at: nil, unsuccessfully_closed_at: nil) }
  scope :client_name_contains, -> name {joins(:client).merge(Client.client_name_contains(name))}
  scope :client_email_contains, -> email {joins(:client).merge(Client.client_email_contains(email))}
  scope :created_at_date_from, -> date {where('buy_processes.created_at >= ?', date.to_date.beginning_of_day)}
  scope :created_at_date_to, -> date {where('buy_processes.created_at <= ?', date.to_date.end_of_day)}
  scope :without_notes, -> { select('buy_processes.*,  count(notes.id) as notes_count').left_outer_joins(:notes).group('buy_processes.id').having('count(notes.id) = 0') }
  scope :successfully_closed_processes, -> { where.not(successfully_closed_at: nil) }
  scope :unsuccessfully_closed_processes, -> { where.not(unsuccessfully_closed_at: nil) }

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
    successfully_closed_at.blank? && unsuccessfully_closed_at.blank?
  end
end
