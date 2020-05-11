class FindCarRequestMailer < ApplicationMailer
  RETOMAUTOS_STAFF_EMAIL = 'mariapaulagallegoc@gmail.com'
  default from: RETOMAUTOS_STAFF_EMAIL

  def staff_email(find_car_request)
    @find_car_request = find_car_request
    mail(to: RETOMAUTOS_STAFF_EMAIL, from: @find_car_request.email, subject: "Solicitud de carro")
  end

  def customer_email(find_car_request)
    @find_car_request = find_car_request
    mail(to: @find_car_request.email, from: RETOMAUTOS_STAFF_EMAIL, subject: "Solicitud de carro")
  end
end