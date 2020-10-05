# Live Mercadolibre Api wrapper that will attempt real calls to the API
# - We created this wrapper for the mercadolibre gem to be able to control how we want it to behave.
# - Create a method for every method in the gem that we want to use.
# - Add here any additional behaviour that is specific to how we want the client to behave in our app
module MercadolibreApi
  class LiveClient
    def initialize(access_token:, refresh_token:, app_id:, app_secret:, base_client_class: Mercadolibre::Api)
      @access_token = access_token
      @refresh_token = refresh_token
      @app_id = app_id
      @app_secret = app_secret
      @base_client = base_client_class.new(access_token: access_token, app_key: app_id, app_secret: app_secret)
    end


    # GET "/questions/#{question_id}" mecadolibre endpoint.
    # @see ./response_samples/get_question.json
    # The Mercadolibre::Api gem parses the json and returns an OpenStruct
    # sample_notified_question_struct = JSON.parse(SAMPLE_QUESTION_JSON, object_class: OpenStruct)
    # @see https://developers.mercadolibre.com.co/es_ar/preguntas-y-respuestas
    # @see https://developers.mercadolibre.com.co/es_ar/gestiona-preguntas-respuestas#Descripcion-de-atributos
    # @see https://github.com/lhconfort/mercadolibre#questions
    def get_question!(question_id)
      response = base_client.get_question(question_id)
      assert_successful_response!(response)
      response
    end

    # @see https://github.com/lhconfort/mercadolibre#questions
    def answer_question!(question_id, text)
      response = base_client.answer_question(question_id, text)
      assert_successful_response!(response)
      response
    end

    # GET "/items/#{item_id}" Public mecadolibre endpoint.
    # @see ./response_samples/get_car.json
    # The Mercadolibre::Api gem parses the json and returns an OpenStruct
    # Some of the relevant attributes are
    # result.title
    # => "Mercedes Benz A 200 Urban 1.6 Tp"
    # result.price
    # => 60900000
    # result.base_price
    # => 60900000
    # result.permalink
    # => "https://carro.mercadolibre.com.co/MCO-555806906-mercedes-benz-a-200-urban-16-tp-_JM"
    # result.thumbnail
    # => "http://mco-s1-p.mlstatic.com/844589-MCO42047621339_062020-I.jpg"
    # result.secure_thumbnail
    # => "https://..."
    # result.pictures
    # => Array<#<OpenStruct id="844589-MCO42047621339_062020", url="http://mco-s1-p.mlstatic.com/844589-MCO42047621339_062020-O.jpg", secure_url="https://mco-s1-p.mlstatic.com/844589-MCO42047621339_062020-O.jpg", size="500x375", max_size="1000x750", quality="">>
    # result.attributes
    # => ...a data structure with the car attributes...
    #
    # @see https://github.com/lhconfort/mercadolibre#items-and-searches
    def get_car!(car_id)
      response = base_client.get_item(car_id)
      assert_successful_response!(response)
      response
    end

    def refresh_and_persist_token!(token_repo: MercadolibreApiAccessToken)
      refresh_result = base_client.update_token(refresh_token)
      assert_successful_response!(refresh_result)

      token_repo.persist_new_credentials!(
        access_token: refresh_result.access_token,
        refresh_token: refresh_result.refresh_token,
        expires_at: refresh_result.expiration_time
      )
      true
    end


    class UnsuccessfulRequest < StandardError; end
    private

    attr_reader :base_client, :access_token, :refresh_token, :app_id, :app_secret

    # The Mercadolibre::Api base_client always returns open structs and the shape of the open
    # struct changes completely depending on whether the request was successful or not
    # For now we are raising an exception for all unsuccessful requests.
    # For example, the following is returned when the access_token has expired
    # => <OpenStruct message="invalid_token", error="not_found", status=401, cause=[]>
    def assert_successful_response!(response)
      return if !(response.respond_to?(:error) && response.status != 200)
      raise UnsuccessfulRequest, response
    end
  end
end
