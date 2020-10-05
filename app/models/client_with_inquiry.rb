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
      client, buy_process, buy_process_inquiry =
        ActiveRecord::Base.transaction do
          client = Client.create_or_update_by_email!(name: client_name, phone: client_phone, email: client_email)

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
