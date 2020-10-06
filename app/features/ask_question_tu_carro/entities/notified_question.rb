module  AskQuestionTuCarro
  module Entities
    class NotifiedQuestion
      attr_reader :remote_id, :remote_created_at, :remote_car_id, :body, :remote_client, :status

      def initialize(remote_id:, remote_created_at:, remote_car_id:, body:, remote_client:, status:)
        @remote_id = remote_id
        @remote_created_at = remote_created_at
        @remote_car_id = remote_car_id
        @body = body
        @remote_client = remote_client
        @status = status
      end

      def answered?
        status == "ANSWERED"
      end
    end
  end
end
