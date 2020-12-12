module  AskQuestionTuCarro
  module Entities
    class InquiryCar
      attr_reader :remote_id, :description, :year, :registration

      def initialize(remote_id:, description:, year:, registration:)
        @remote_id = remote_id
        @description = description
        @year = year
        @registration = registration
      end
    end
  end
end
