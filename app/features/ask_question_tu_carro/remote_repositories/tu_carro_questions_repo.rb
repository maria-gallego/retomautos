module AskQuestionTuCarro
  module RemoteRepositories
    class TuCarroQuestionsRepo

      # @param mercadolibre_api [#get_guestion!, MercadolibreApi::LiveClient, MercadolibreApi::DummyClient]
      def initialize(mercadolibre_api: MercadolibreApi::ClientFactory.build_client_from_config)
        @mercadolibre_api = mercadolibre_api
      end

      def find_by_id!(remote_question_id)
        notified_question_struct = mercadolibre_api.get_question!(remote_question_id)

        client_struct = notified_question_struct.from
        inquirring_client = AskQuestionTuCarro::Entities::InquiringClient.new(
          remote_id: client_struct.id,
          name: "#{client_struct.first_name.strip} #{client_struct.last_name.strip}",
          phone: client_struct.dig(:phone, :number),
          email: client_struct.email
        )

        notified_question = AskQuestionTuCarro::Entities::NotifiedQuestion.new(
          remote_id: notified_question_struct.id,
          body: notified_question_struct.text,
          remote_created_at: DateTime.parse(notified_question_struct.date_created),
          remote_car_id: notified_question_struct.item_id,
          remote_client: inquirring_client
        )

        notified_question
      end

      def answer_question!(remote_question_id, text)
        mercadolibre_api.answer_question!(remote_question_id, text)
      end

      private

      attr_reader :mercadolibre_api
    end
  end
end


