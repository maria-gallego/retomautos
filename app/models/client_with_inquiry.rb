class ClientWithInquiry
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :client_name, :client_email, :client_phone, :buy_process_inquiry_body, :source

  validates :client_name, presence: true
  validates :client_email,
            format: { with: Devise.email_regexp, message: "email inválido" },
            presence: true
  validates :buy_process_inquiry_body, presence: true
  validates :source, presence: true

  # Callback
  # ========================
  before_validation :normalize_client_email

  def save
    if valid?
      client, assigned_salesperson, buy_process, buy_process_inquiry =
        ActiveRecord::Base.transaction do
          client = Client.create_or_update_by_email!(name: client_name, phone: client_phone, email: client_email)

          assigned_salesperson = BuyProcess.determine_salesperson(client)
          buy_process = BuyProcess.create!(source: source, client: client, user: assigned_salesperson)

          buy_process_inquiry = BuyProcessInquiry.create!(body: buy_process_inquiry_body, buy_process: buy_process)
          [client, assigned_salesperson, buy_process, buy_process_inquiry]
        end

      ClientWithInquiryMailer.staff_email(
          salesperson: assigned_salesperson,
          client: client,
          buy_process: buy_process,
          buy_process_inquiry: buy_process_inquiry,
      ).deliver_now

      return true
    else
      return false
    end
  end




  private

  def normalize_client_email
    self.client_email = self.client_email.downcase.strip unless self.client_email.nil?
  end
end
