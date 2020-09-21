require 'tu_carro_question_responder/use_cases/inquiring_client'
require 'tu_carro_question_responder/use_cases/notified_question'

module TuCarroQuestionResponder
  module RemoteRepositories
    class TuCarroQuestionsRepo

      def initialize(
        mercadolibre_api_factory: Mercadolibre::Api,
        access_token: "APP_USR-6183539405320299-092012-449f1dadfbd72e4ff495295551460780-28140600")
        @mercadolibre_api = mercadolibre_api_factory.new(access_token: access_token)
      end

      # The Mercadolibre api returns a JSON with the following structure for the "/questions/#{question_id}" endpoint.
      # The Mercadolibre gem parses the json and returns an OpenStruct
      # SAMPLE_QUESTION_JSON = <<~JSON
      #   {
      #     "id": 11497699553,
      #     "seller_id": 28140600,
      #     "text": "hola le escribi que cual era su minimo y me opidio que le ofreciera",
      #     "status": "UNANSWERED",
      #     "item_id": "MCO583043192",
      #     "date_created": "2020-09-19T23:22:32.734-04:00",
      #     "hold": false,
      #     "deleted_from_listing": false,
      #     "answer": null,
      #     "from": {
      #       "id": 163115900,
      #       "answered_questions": 0,
      #       "first_name": "Alfredo Enrique",
      #       "last_name": "Campo Ortiz",
      #       "phone": {
      #         "number": "3003133396",
      #         "area_code": " "
      #       },
      #       "email": "revisoriaac@hotmail.com"
      #     }
      #   }
      # JSON
      # sample_notified_question_struct = JSON.parse(SAMPLE_QUESTION_JSON, object_class: OpenStruct)
      # @see https://developers.mercadolibre.com.co/es_ar/preguntas-y-respuestas
      # @see https://developers.mercadolibre.com.co/es_ar/gestiona-preguntas-respuestas#Descripcion-de-atributos
      # @see https://github.com/lhconfort/mercadolibre#questions
      def find_by_id(remote_question_id)
        notified_question_struct = mercadolibre_api.get_question(remote_question_id)

        client_struct = notified_question_struct.from
        inquirring_client = TuCarroQuestionResponder::UseCases::InquiringClient.new(
          remote_id: client_struct.id,
          name: "#{client_struct.first_name.strip} #{client_struct.last_name.strip}",
          phone: client_struct.dig(:phone, :number),
          email: client_struct.email
        )

        notified_question = TuCarroQuestionResponder::UseCases::NotifiedQuestion.new(
          remote_id: notified_question_struct.id,
          body: notified_question_struct.text,
          remote_created_at: DateTime.parse(notified_question_struct.date_created),
          remote_car_id: notified_question_struct.item_id,
          remote_client: inquirring_client
        )

        notified_question
      end

      private

      attr_reader :mercadolibre_api
    end
  end
end


