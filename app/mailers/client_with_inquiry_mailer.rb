class ClientWithInquiryMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'maria.gallego@retomautos.com'
  default from: SENDGRID_VERIFIED_SENDER

  def staff_email(salesperson:, client:, buy_process:, buy_process_inquiry:)
    @salesperson = salesperson
    @client = client
    @buy_process = buy_process
    @buy_process_inquiry = buy_process_inquiry
    mail(to: ["mariapaulagallegoc@gmail.com", salesperson.email], subject: "Pregunta de Cliente")
  end
end
