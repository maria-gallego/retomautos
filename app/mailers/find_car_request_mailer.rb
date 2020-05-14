class FindCarRequestMailer < ApplicationMailer
  SENDGRID_VERIFIED_SENDER = 'felipe.gallego@retomautos.com'
  default from: SENDGRID_VERIFIED_SENDER
  #default from: OWNER_EMAIL

  def staff_email(find_car_request)
    @find_car_request = find_car_request
    mail(to: [SENDGRID_VERIFIED_SENDER, 'mariapaulagallegoc@gmail.com'], subject: "Solicitud de carro")
  end

  def customer_email(find_car_request)
    @find_car_request = find_car_request
    mail(to: @find_car_request.email, subject: "Solicitud de carro")
  end
end