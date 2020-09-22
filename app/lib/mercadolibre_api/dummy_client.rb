# A dummy for the LiveClient that always returns hardcoded data in the same format
# as the live client
module MercadolibreApi
  class DummyClient
    def get_question!(question_id)
      sample_question_json = <<~JSON
        {
          "id": 11497699553,
          "seller_id": 28140600,
          "text": "hola le escribi que cual era su minimo y me opidio que le ofreciera",
          "status": "UNANSWERED",
          "item_id": "MCO583043192",
          "date_created": "2020-09-19T23:22:32.734-04:00",
          "hold": false,
          "deleted_from_listing": false,
          "answer": null,
          "from": {
            "id": 163115900,
            "answered_questions": 0,
            "first_name": "Alfredo Enrique",
            "last_name": "Campo Ortiz",
            "phone": {
              "number": "3003133396",
              "area_code": " "
            },
            "email": "revisoriaac@hotmail.com"
          }
        }
      JSON
      JSON.parse(sample_question_json, object_class: OpenStruct)
    end
  end
end



