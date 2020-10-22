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
  has_many :buy_processes
  has_many :car_interests, through: :buy_processes
  has_many :buy_process_inquiries, through: :buy_processes

  # Callback
  # ========================
  before_validation :normalize_email

  #
  # Scope
  ## ========================
  scope :client_name_contains, -> (name) {where("name ILIKE ?", "%#{name}%")}
  scope :client_email_contains, -> (email) {where("email ILIKE ?", "%#{email}%")}

  ## Class Methods
  ## ========================
  def self.create_or_update_by_email!(client_attributes)
    email = client_attributes.fetch(:email)
    client = Client.find_by(email: email)
    if client.present?
      client.update!(**client_attributes)
    else
      client = Client.create!(**client_attributes)
    end
    client
  end


  private

  def normalize_email
    self.email = self.email.downcase.strip unless self.email.nil?
  end
end
