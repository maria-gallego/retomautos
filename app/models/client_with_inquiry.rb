class ClientWithInquiry
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :client_name, :client_email, :client_phone, :buy_process_inquiry_body, :source

  # WARNING: if you are changing validations, make sure to update Client accordingly
  validates :client_name, presence: true

  validates :client_email,
            format: { with: Devise.email_regexp, message: "Email inválido" },
            if: -> { client_email.present? }

  validates :client_phone,
            numericality: true,
            length: { minimum: 7, maximum: 13 },
            if: -> { client_phone.present? }

  validate :phone_or_email_is_present

  validates :buy_process_inquiry_body, presence: true
  validates :source, presence: true

  # Callback
  # ========================
  before_validation :normalize_client_email
  before_validation :normalize_client_phone

  def save
    if valid?
      client, buy_process, buy_process_inquiry =
        ActiveRecord::Base.transaction do
          client = Client.create_or_update_by_email_or_phone!(name: client_name, phone: client_phone, email: client_email)

          buy_process = BuyProcess.find_open_or_create_for_client!(client, source)
          buy_process.assign_sales_person_if_non_existent!

          buy_process_inquiry = BuyProcessInquiry.create!(body: buy_process_inquiry_body, buy_process: buy_process)
          [client, buy_process, buy_process_inquiry]
        end

      ClientWithInquiryMailer.staff_email(
          salesperson: buy_process.user,
          client: client,
          buy_process: buy_process,
          buy_process_inquiry: buy_process_inquiry,
      ).deliver_later

      return true
    else
      return false
    end
  end


  private

  def phone_or_email_is_present
    errors.add(:base, "Por favor provee tu email o teléfono") if client_email.blank? && client_phone.blank?
  end

  def normalize_client_email
    self.client_email = Normalizer.normalize_email(self.client_email) if self.client_email.present?
  end

  def normalize_client_phone
    self.client_phone = Normalizer.normalize_phone(self.client_phone) if self.client_phone.present?
  end
end
