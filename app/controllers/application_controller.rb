class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    if current_user.has_role?('sales')
      sales_buy_processes_path
    elsif current_user.has_role?('admin')
      admin_buy_processes_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def  set_car_slides
    @slide1_cars = [
        CarInformation.new(
            make: 'Ford',
            model: 'Mustang',
            year: '2017',
            additional_information: '5.0 Gt Premium',
            image_url: 'fotos_tu_carro/mustang_apr.jpg',
            #showcase_video_url: 'https://youtu.be/EKyFdyOHw9w',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-613136185-ford-mustang-gt-50-_JM#position=1&type=item&tracking_id=113a5eaa-4e30-46e7-8523-76d914bb32bb'
        ),
        CarInformation.new(
            make: 'Mini',
            model: 'Cooper',
            year: '2010',
            additional_information: '1.6 R56 S Coupe 175 hp',
            image_url: 'fotos_tu_carro/mini_may.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-628686432-mini-cooper-s-paquete-jcw-_JM#position=1&search_layout=grid&type=item&tracking_id=ff3625e8-f323-4102-ba2b-b0ec82d106be'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase A',
            year: '2020',
            additional_information: 'Hatchback',
            image_url: 'fotos_tu_carro/mercedes_clasea_apr.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-613319786-mercedes-benz-clase-a-_JM#position=5&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
        CarInformation.new(
            make: 'Ford',
            model: 'Fusion',
            year: '2016',
            additional_information: '2.0 Titanium',
            image_url: 'fotos_tu_carro/ford_may.jpg',
            #showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-616101798-ford-fusion-2016-20-titanium-_JM#position=8&search_layout=grid&type=item&tracking_id=c5805fbb-6290-41e8-bb67-0650b65d1c57'
        ),
    ]

    @slide2_cars = [
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'GLE',
            year: '2017',
            additional_information: '250d 4matic',
            image_url: 'fotos_tu_carro/mercedes_gle2017_apr.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-612638058-mercedes-benz-clase-gle-250d-4matic-_JM#position=8&type=item&tracking_id=60f17f98-f91f-4745-8d23-64e968c293b8'
        ),
        CarInformation.new(
            make: 'Ford',
            model: 'Ecosport 2',
            year: '2018',
            additional_information: '2.0 Se',
            image_url: 'fotos_tu_carro/ecosport_apr.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-612638696-ford-ecosport-2018-se-mt-_JM#position=8&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase C',
            year: '2020',
            additional_information: 'C 200',
            image_url: 'fotos_tu_carro/mercedes_c200_apr.jpg',
            #showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-612308812-mercedes-benz-clase-c-c200-_JM#position=10&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 4',
            year: '2014',
            additional_information: '420i F32 Coupe Sportline',
            image_url: 'fotos_tu_carro/bmw_mayo.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-627559936-bmw-serie-4-_JM#position=2&search_layout=grid&type=item&tracking_id=ff3625e8-f323-4102-ba2b-b0ec82d106be'
        ),
    ]
    @slide3_cars = [
        CarInformation.new(
            make: 'Mini',
            model: 'Countryman',
            year: '2018',
            additional_information: '2.0 F60 Cooper S Chili',
            image_url: 'fotos_tu_carro/mini_countryman_apr.jpg',
            #showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-611673264-mini-cooper-s-countryman-chili-_JM#position=13&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
        CarInformation.new(
            make: 'Volvo',
            model: 'V 40',
            year: '2019',
            additional_information: '1.5 T3 Drive-e Sport',
            image_url: 'fotos_tu_carro/volvo_mayo.jpg',
            #showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-623356717-volvo-v40-_JM#position=5&search_layout=grid&type=item&tracking_id=9a151a77-1d5e-4af3-8489-5f672df0472f'
        ),
        CarInformation.new(
            make: 'Land Rover',
            model: 'Freelander',
            year: '2013',
            additional_information: '2.0 Hse Si4',
            image_url: 'fotos_tu_carro/landrover_may.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-618831823-land-rover-freelander-2013-20-hse-si4-_JM#position=9&search_layout=grid&type=item&tracking_id=4850c59b-03a2-498f-8020-099834902379'
        ),
        CarInformation.new(
            make: 'Nissan',
            model: 'Qashqai',
            year: '2015',
            additional_information: '+ 2',
            image_url: 'fotos_tu_carro/nissan_qashqai_mayo.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-623914730-nissan-qashqai-2-_JM#position=4&search_layout=grid&type=item&tracking_id=f3c3e1d5-4e43-473c-b192-451ff6751615'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase E',
            year: '2016',
            additional_information: 'Cgi 184 Hp',
            image_url: 'fotos_tu_carro/mercedes_clasee_apr.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-610069318-mercedes-benz-clase-e-e200-_JM#position=29&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'X3 3.0',
            year: '2017',
            additional_information: 'F25 Xdrive30d',
            image_url: 'fotos_tu_carro/bmw_x3_may.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-619157888-bmw-x3-_JM#position=6&search_layout=grid&type=item&tracking_id=c5805fbb-6290-41e8-bb67-0650b65d1c57'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'I3',
            year: '2020',
            additional_information: '',
            image_url: 'fotos_tu_carro/bmw_i3_mayo.jpg',
            #showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-615927715-bmw-i3-_JM#position=39&search_layout=grid&type=item&tracking_id=e8cbfb45-f41f-4458-9530-e4f1e16f3638'
        ),
        CarInformation.new(
            make: 'Mercedes-Benz',
            model: 'Clase C',
            year: '2019',
            additional_information: 'C 1.6 Avantgarde',
            image_url: 'fotos_tu_carro/mercedes_clasec_may.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-619153628-mercedes-benz-clase-c-_JM#position=7&search_layout=grid&type=item&tracking_id=c5805fbb-6290-41e8-bb67-0650b65d1c57'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
