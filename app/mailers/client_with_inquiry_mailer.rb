class ClientWithInquiryMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'maria.gallego@retomautos.com'
  default from: SENDGRID_VERIFIED_SENDER

  def staff_email(user:, client:, inquiry:)
    @client = client
    @inquiry = inquiry

    mail(to: [SENDGRID_VERIFIED_SENDER, user.email], subject: "Pregunta de Cliente")
  end
end
