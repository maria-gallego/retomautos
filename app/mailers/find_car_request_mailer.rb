class FindCarRequestMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'maria.gallego@retomautos.com'
  default from: SENDGRID_VERIFIED_SENDER

  def staff_email(find_car_request)
    @find_car_request = find_car_request
    salesperson = find_car_request.salesperson
    mail(to: [salesperson.email], subject: "Solicitud de carro")
  end

  def customer_email(find_car_request)
    @find_car_request = find_car_request
    mail(to: @find_car_request.email, subject: "Solicitud de carro")
  end
end