require 'tu_carro_question_responder/remote_repositories/tu_carro_questions_repo'

module TuCarroQuestionResponder
  module UseCases
    class ProcessQuestionNotification

      def initialize(
        remote_questions_repo: TuCarroQuestionResponder::RemoteRepositories::TuCarroQuestionsRepo.new
      )
        @remote_questions_repo = remote_questions_repo
      end

      def call(remote_question_id)
        notified_question = remote_questions_repo.find_by_id(remote_question_id)
        notified_question

        # Upsert client in local DB
        # Assign a salesperson to client
        # Create question in local DB associated to client
        # Send email to stalesperson about question

        # Autorespond to mercadolibre


        # TODO: remove crutch
        # question_notification = TuCarroQuestionResponder::UseCases::QuestionNotification.from_mercadolibre_question_callback(nil)

        # notified_question = questions_repo.fetch_by_id(question_notification.remote_question_id)
        # notified_question_client = notified_question.client

        # Upsert client in local DB
        # Update question in local DB
        # Notify salesman via email
        # Answer question in tu carro
      end

      private

      attr_reader :remote_questions_repo
    end
  end
end
