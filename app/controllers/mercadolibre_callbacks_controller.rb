require 'tu_carro_question_responder/use_cases/process_question_notification'

class MercadolibreCallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def notify
    # TODO: make processing async
    TuCarroQuestionResponder::UseCases::ProcessQuestionNotification.new.call(remote_question_id)
    head :ok
  end

  private

  def remote_question_id
    params.permit(:resource).fetch(:resource).split("/questions/").last.to_i
  end
end
