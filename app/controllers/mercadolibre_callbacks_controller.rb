class MercadolibreCallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def notify
    notification_topic = notification_params[:topic]
    case notification_topic
    when "questions"
      schedule_question_notification_processing
    else
      # No op. It is safe to ignore other notifications.
    end
    head :ok
  end

  private

  def schedule_question_notification_processing
    remote_question_id = notification_params.fetch(:resource).split("/questions/").last.to_i
    AskQuestionTuCarro::Jobs::ProcessQuestionNotificationJob.perform_later(remote_question_id)
  end

  def notification_params
    params.permit(:resource, :topic)
  end
end
