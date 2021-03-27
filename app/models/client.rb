class Client < ApplicationRecord
  # Validations
  # ========================
  # WARNING: if you are changing validations, make sure to update Client with Inquiry accordingly
  validates :name, presence: true
  validates :email,
            format: { with: Devise.email_regexp, message: "email inválido" },
            uniqueness: true,
            if: -> { email.present? }

  validates :phone,
            numericality: true,
            length: { minimum: 7, maximum: 13 },
            uniqueness: true,
            if: -> { phone.present? }

  validate :phone_or_email_is_present

  # Associations
  # ========================
  has_many :buy_processes
  has_many :car_interests, through: :buy_processes
  has_many :buy_process_inquiries, through: :buy_processes

  # Callback
  # ========================
  before_validation :normalize_email
  before_validation :normalize_phone

  #
  # Scope
  ## ========================
  scope :client_name_contains, -> (name) {where("clients.name ILIKE ?", "%#{name}%")}
  scope :client_email_contains, -> (email) {where("clients.email ILIKE ?", "%#{email}%")}

  ## Class Methods
  ## ========================
  def self.find_by_email_or_phone(search_email: nil, search_phone: nil)
    if search_email.present?
      search_email = Normalizer.normalize_email(search_email)
    else
      search_email = "non-existent-email"
    end
    # search_email possibilities: "email@email.com", "non-existent-email"

    if search_phone.present?
      search_phone = Normalizer.normalize_phone(search_phone)
    else
      search_phone = "non-existent-phone"
    end
    # search_phone possibilities: "3102894284", "non-existent-phone"

    Client.where(email: search_email).or(Client.where(phone: search_phone)).first
  end


  def self.create_or_update_by_email_or_phone!(client_attributes)
    search_email = client_attributes.fetch(:email, nil)
    search_phone = client_attributes.fetch(:phone, nil)
    client = Client.find_by_email_or_phone(search_email: search_email, search_phone: search_phone)

    if client.present?
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
    self.email = Normalizer.normalize_email(self.email) if self.email.present?
  end

  def normalize_phone
    self.phone = Normalizer.normalize_phone(self.phone) if self.phone.present?
  end

  def open_buy_processes
    buy_processes.currently_open
  end

  def phone_or_email_is_present
    errors.add(:base, "el cliente debe tener email o teléfono") if email.blank? && phone.blank?
  end
end
