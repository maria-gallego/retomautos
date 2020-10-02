class ClientWithInquiryMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'mariapaulagallegoc@gmail.com'
  default from: SENDGRID_VERIFIED_SENDER

  def staff_email(salesperson:, client:, buy_process:, buy_process_inquiry:)
    @salesperson = salesperson
    @client = client
    @buy_process = buy_process
    @buy_process_inquiry = buy_process_inquiry
    mail(to: [SENDGRID_VERIFIED_SENDER, salesperson.email], subject: "Pregunta de Cliente")
  end
end
