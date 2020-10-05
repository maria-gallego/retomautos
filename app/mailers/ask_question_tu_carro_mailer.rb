class AskQuestionTuCarroMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'maria.gallego@retomautos.com'
  default from: SENDGRID_VERIFIED_SENDER

  def staff_email(salesperson:, client:, buy_process:, car_interest_inquiry:, car:)
    @salesperson = salesperson
    @client = client
    @buy_process = buy_process
    @car_interest_inquiry = car_interest_inquiry
    @car = car
    mail(to: ["mariapaulagallegoc@gmail.com", salesperson.email], subject: "Pregunta de Cliente desde Tu Carro")
  end
end
