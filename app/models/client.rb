class Client < ApplicationRecord
  # Validations
  # ========================
  validates :name, presence: true
  validates :email,
            format: { with: Devise.email_regexp, message: "email inválido" },
            uniqueness: true

  # Associations
  # ========================
  has_many :buy_processes
  has_many :car_interests, through: :buy_processes
  has_many :buy_process_inquiries, through: :buy_processes

  # Callback
  # ========================
  before_validation :normalize_email

  #
  # Scope
  ## ========================
  scope :client_name_contains, -> (name) {where("clients.name ILIKE ?", "%#{name}%")}
  scope :client_email_contains, -> (email) {where("clients.email ILIKE ?", "%#{email}%")}

  ## Class Methods
  ## ========================
  def self.create_or_update_by_email_or_phone!(client_attributes)
    email = client_attributes.fetch(:email)
    phone = client_attributes.fetch(:phone)
    client_with_email = Client.find_by(email: email)
    client_with_phone = Client.find_by(phone: phone)
    if client_with_email.present?
      client.update!(**client_attributes)
    elsif client_with_phone.present?
      client.update!(**client_attributes)
    else
      client = Client.create!(**client_attributes)
    end
    client
  end

  ## Instance Methods
  ## ========================
  def last_buy_process
    buy_processes.last
  end

  def last_open_buy_process
    open_buy_processes.last
  end

  def has_open_buy_process?
    open_buy_processes.exists?
  end

  private

  def normalize_email
    self.email = self.email.downcase.strip unless self.email.nil?
  end

  def open_buy_processes
    buy_processes.currently_open
  end

end
