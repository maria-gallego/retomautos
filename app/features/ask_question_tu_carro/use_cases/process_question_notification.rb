module AskQuestionTuCarro
  module UseCases
    class ProcessQuestionNotification

      def initialize(
        remote_questions_repo: AskQuestionTuCarro::RemoteRepositories::TuCarroQuestionsRepo.new,
        remote_cars_repo: AskQuestionTuCarro::RemoteRepositories::TuCarroCarsRepo.new
      )
        @remote_questions_repo = remote_questions_repo
        @remote_cars_repo = remote_cars_repo
      end

      def call(remote_question_id)
        # If this remote question id has already been processed, do nothing.
        # This was added because mercadolibre sometimes notifies about the same question more than once
        if CarInterestInquiry.inquiry_with_tu_carro_question_id_exists?(remote_question_id)
          Rails.logger.warn "Remote question #{remote_question_id} has already been processed. Ignoring."
          return
        end

        notified_question = remote_questions_repo.find_by_id!(remote_question_id)
        if notified_question.answered?
          Rails.logger.warn "Remote question #{remote_question_id} has already been answered. Ignoring."
          return
        end

        if happened_more_than_24_hours_ago?(notified_question)
          Rails.logger.warn "Remote question #{remote_question_id} was created more than 24 hours ago. Ignoring."
          return
        end

        inquiring_client = notified_question.remote_client
        remote_car = remote_cars_repo.find_by_id!(notified_question.remote_car_id)

        client, buy_process, car, car_interest_inquiry =
          ActiveRecord::Base.transaction do
            client = Client.create_or_update_by_email!(
              name: inquiring_client.name,
              phone: inquiring_client.phone,
              email: inquiring_client.email
            )

            car = Car.create_or_update_by_tu_carro_id!(
              tu_carro_id: remote_car.remote_id,
              description: remote_car.description,
              year: remote_car.year
            )

            buy_process = BuyProcess.find_open_or_create_for_client!(client, "Tu Carro")
            buy_process.assign_sales_person_if_non_existent!

            car_interest = CarInterest.find_or_create_for!(buy_process: buy_process, car: car)
            car_interest_inquiry = CarInterestInquiry.create!(
              car_interest: car_interest,
              body: notified_question.body,
              tu_carro_question_id: remote_question_id
            )

            [client, buy_process, car, car_interest_inquiry]
          end

        # Send email to sales person
        AskQuestionTuCarroMailer.staff_email(
          salesperson: buy_process.user,
          client: client,
          buy_process: buy_process,
          car_interest_inquiry: car_interest_inquiry,
          car: car
          ).deliver_later

        # Respond to user in tu carro
        response_text = tu_carro_automatic_response_text(client)
        remote_questions_repo.try_to_answer_question(remote_question_id, response_text)
      end

      private

      attr_reader :remote_questions_repo, :remote_cars_repo

      def tu_carro_automatic_response_text(client)
        "Hola #{client.name}! Gracias por contactarnos. Uno de nuestro asesores se va a comunicar contigo para responder tus preguntas. Puedes visitarnos en la Carrera 15 #103-24, o en la Calle 105A #14-41 en nuestro nuevos horarios de atención de lunes a viernes de 10 am a 7 pm, sábados de 10 am - 7 pm y domingos de 10 am - 5 pm. Visita nuestra página www.retomautos.com"
      end

      def happened_more_than_24_hours_ago?(notified_question)
        24.hours.ago > notified_question.remote_created_at
      end
    end
  end
end
