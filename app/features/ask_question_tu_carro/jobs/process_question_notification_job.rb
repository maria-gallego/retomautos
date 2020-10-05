module AskQuestionTuCarro
  module Jobs
    class ProcessQuestionNotificationJob < ApplicationJob
      def perform(remote_question_id)
        AskQuestionTuCarro::UseCases::ProcessQuestionNotification.new.call(remote_question_id)
      end
    end
  end
end
