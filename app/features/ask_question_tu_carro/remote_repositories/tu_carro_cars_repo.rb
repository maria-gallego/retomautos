module AskQuestionTuCarro
  module RemoteRepositories
    class TuCarroCarsRepo

      # @param mercadolibre_api [#get_guestion!, MercadolibreApi::LiveClient, MercadolibreApi::DummyClient]
      def initialize(mercadolibre_api: MercadolibreApi::ClientFactory.build_client_from_config)
        @mercadolibre_api = mercadolibre_api
      end

      def find_by_id!(remote_car_id)
        car_struct = mercadolibre_api.get_car!(remote_car_id)
        AskQuestionTuCarro::Entities::InquiryCar.new(
          remote_id: car_struct.id,
          description: car_struct.title,
          year: car_struct.attributes.find{ |attribute| attribute.id == "VEHICLE_YEAR"}.value_name.to_i,
          registration: car_struct.attributes.find{ |attribute| attribute.id == "LICENSE_PLATE"}.value_name
        )
      end

      private

      attr_reader :mercadolibre_api
    end
  end
end



