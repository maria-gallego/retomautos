# Live Mercadolibre Api wrapper that will attempt real calls to the API
# - We created this wrapper for the mercadolibre gem to be able to control how we want it to behave.
# - Create a method for every method in the gem that we want to use.
# - Add here any additional behaviour that is specific to how we want the client to behave in our app
module MercadolibreApi
  class LiveClient
    def initialize(access_token:, app_id:, app_secret:, base_client_class: Mercadolibre::Api)
      @access_token = access_token
      @app_id = app_id
      @app_secret = app_secret
      @base_client = base_client_class.new(access_token: access_token, app_key: app_id, app_secret: app_secret)
    end

    # The Mercadolibre api returns a JSON with the following structure for the "/questions/#{question_id}" endpoint.
    # The Mercadolibre::Api gem parses the json and returns an OpenStruct
    # SAMPLE_QUESTION_JSON = <<~JSON
    #   {
    #     "id": 11497699553,
    #     "seller_id": 28140600,
    #     "text": "hola le escribi que cual era su minimo y me pidio que le ofreciera",
    #     "status": "UNANSWERED",
    #     "item_id": "MCO583043192",
    #     "date_created": "2020-09-19T23:22:32.734-04:00",
    #     "hold": false,
    #     "deleted_from_listing": false,
    #     "answer": null,
    #     "from": {
    #       "id": 163115900,
    #       "answered_questions": 0,
    #       "first_name": "Alfredo Enrique",
    #       "last_name": "Campo Ortiz",
    #       "phone": {
    #         "number": "3003133396",
    #         "area_code": " "
    #       },
    #       "email": "revisoriaac@hotmail.com"
    #     }
    #   }
    # JSON
    # sample_notified_question_struct = JSON.parse(SAMPLE_QUESTION_JSON, object_class: OpenStruct)
    # @see https://developers.mercadolibre.com.co/es_ar/preguntas-y-respuestas
    # @see https://developers.mercadolibre.com.co/es_ar/gestiona-preguntas-respuestas#Descripcion-de-atributos
    # @see https://github.com/lhconfort/mercadolibre#questions
    def get_question!(question_id)
      response = base_client.get_question(question_id)
      assert_successful_response!(response)
      response
    end


    class UnsuccessfulRequest < StandardError; end
    private

    attr_reader :base_client, :access_token, :app_id, :app_secret

    # The Mercadolibre::Api base_client always returns open structs and the shape of the open
    # struct changes completely depending on whether the request was successful or not
    # For now we are raising an exception for all unsuccessful requests.
    # For example, the following is returned when the access_token has expired
    # => <OpenStruct message="invalid_token", error="not_found", status=401, cause=[]>
    def assert_successful_response!(response)
      return if response.respond_to?(:status) && response.status == 200
      raise UnsuccessfulRequest, response
    end
  end
end
