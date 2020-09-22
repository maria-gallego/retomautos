module  AskQuestionTuCarro
  module UseCases
    class NotifiedQuestion
      attr_reader :remote_id, :remote_created_at, :remote_car_id, :body, :remote_client

      def initialize(remote_id:, remote_created_at:, remote_car_id:, body:, remote_client:)
        @remote_id = remote_id
        @remote_created_at = remote_created_at
        @remote_car_id = remote_car_id
        @body = body
        @remote_client = remote_client
      end
    end
  end
end
