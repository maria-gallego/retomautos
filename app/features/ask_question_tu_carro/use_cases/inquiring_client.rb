module  AskQuestionTuCarro
  module UseCases
    class InquiringClient
      attr_reader :remote_id, :name, :phone, :email

      def initialize(remote_id:, name:, phone: , email:)
        @remote_id = remote_id
        @name = name
        @phone = phone
        @email = email
      end
    end
  end
end
