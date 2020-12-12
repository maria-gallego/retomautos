class AskQuestionTuCarroMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'maria.gallego@retomautos.com'
  default from: SENDGRID_VERIFIED_SENDER

  def staff_email(salesperson:, client:, buy_process:, car_interest_inquiry:, car:)
    @salesperson = salesperson
    @client = client
    @buy_process = buy_process
    @car_interest_inquiry = car_interest_inquiry
    @car = car
    mail(to: [salesperson.email], subject: "Pregunta de Tu Carro. Proceso ##{@buy_process.id}")
  end
end
