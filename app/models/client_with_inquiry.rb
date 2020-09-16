class ClientWithInquiry
  include ActiveModel::Model
  attr_accessor :client_name, :client_email, :client_phone, :inquiry_body

  validates :client_name, presence: true
  validates :client_email,
            format: { with: Devise.email_regexp, message: "email inválido" },
            presence: true
  validates :inquiry_body, presence: true


  def save
    if valid?
      ActiveRecord::Base.transaction do
        client = create_or_update_client(client_name: client_name, client_phone: client_phone, client_email: client_email)
        assign_salesperson!(client)
        Inquiry.create!(body: inquiry_body, client: client)
        # send email
      end
      return true
    else
      return false
    end
  end

  private

  def create_or_update_client(client_name:, client_phone:, client_email:)
    client = Client.find_by(email: client_email)
    if client.present?
      client.update!(name: client_name, phone: client_phone)
    else
      client = Client.create!(name: client_name, phone: client_phone, email: client_email)
    end
    client
  end

  def assign_salesperson!(client)
    if !client.has_salesperson?
      next_salesperson = Client.next_salesperson
      client.update!(user: next_salesperson)
    end
  end
end