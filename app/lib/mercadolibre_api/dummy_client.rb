# A dummy for the LiveClient that always returns hardcoded data in the same format
# as the live client
module MercadolibreApi
  class DummyClient
    # @see ./response_samples/get_question.json
    def get_question!(question_id)
      sample_question_json = File.read("app/lib/mercadolibre_api/response_samples/get_question.json")
      JSON.parse(sample_question_json, object_class: OpenStruct)
    end

    # @see https://github.com/lhconfort/mercadolibre#questions
    def answer_question!(question_id, text)
      sample_answer_question_json = File.read("app/lib/mercadolibre_api/response_samples/answer_question.json")
      JSON.parse(sample_answer_question_json, object_class: OpenStruct)
    end

    def get_car!(car_id)
      sample_car_json = File.read("app/lib/mercadolibre_api/response_samples/get_car.json")
      JSON.parse(sample_car_json, object_class: OpenStruct)
    end

    def refresh_and_persist_token!(token_repo: nil)
      # No Op. Dummy clients do not need to update tokens
      true
    end
  end
end



