module  AskQuestionTuCarro
  module Entities
    class InquiryCar
      attr_reader :remote_id, :description, :year

      def initialize(remote_id:, description:, year:)
        @remote_id = remote_id
        @description = description
        @year = year
      end
    end
  end
end
