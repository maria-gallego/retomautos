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
            make: 'BMW',
            model: 'Serie 5 520i',
            year: '2012',
            additional_information: '2.0 F10',
            image_url: 'fotos_tu_carro/bmw_serie5_apr.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-614463562-bmw-520i-tp-_JM#position=4&type=item&tracking_id=60f17f98-f91f-4745-8d23-64e968c293b8'
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
            make: 'Mercedes Benz',
            model: 'GLC',
            year: '2017',
            additional_information: '2.0 4matic',
            image_url: 'fotos_tu_carro/mercedes_glc20_apr.jpg',
            #showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-614464766-mercedes-benz-glc-250-_JM#position=2&type=item&tracking_id=60f17f98-f91f-4745-8d23-64e968c293b8'
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
            make: 'Mini',
            model: 'Cooper 1.6',
            year: '2011',
            additional_information: 'R56 John Cooper Works',
            image_url: 'fotos_tu_carro/mini_jcw_apr.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-614465107-mini-jcw-cooper-s-mt-_JM#position=3&type=item&tracking_id=60f17f98-f91f-4745-8d23-64e968c293b8'
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
            make: 'Ford',
            model: 'Explorer',
            year: '2018',
            additional_information: '2.3 Limited 4x4',
            image_url: 'fotos_tu_carro/fordexplorer_apr.jpg',
            #showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-612582860-ford-explorer-23-limited-4x4-_JM#position=24&type=item&tracking_id=60f17f98-f91f-4745-8d23-64e968c293b8'
        ),
        CarInformation.new(
            make: 'Mazda',
            model: '2',
            year: '2020',
            additional_information: '1.5 Grand Touring Lx Sedan',
            image_url: 'fotos_tu_carro/mazda2_apr.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-610047519-mazda-2-grand-touring-lx-_JM#position=23&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'M240i',
            year: '2017',
            additional_information: '340 Hp 3.0 Tp',
            image_url: 'fotos_tu_carro/bmw240_arp.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-606765065-bmw-m240i-340-hp-30-tp-_JM#position=24&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
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
            make: 'Mercedes Benz',
            model: 'Clase E 200',
            year: '2020',
            additional_information: 'Avantgarde',
            image_url: 'fotos_tu_carro/mercedes_aavantgarde_apr.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-612307346-mercedes-benz-clase-e-e200-_JM#position=17&type=item&tracking_id=ab27f2d0-3d50-4900-ae9f-a3103df21299'
        ),
        CarInformation.new(
            make: 'Audi',
            model: 'A3',
            year: '2017',
            additional_information: '1.8 Ambition Stronic',
            image_url: 'fotos_tu_carro/audia3_apr.jpg',
            #showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-615004875-audi-a3-18t-ambition-stronic-_JM#position=33&type=item&tracking_id=60f17f98-f91f-4745-8d23-64e968c293b8'
        ),
        CarInformation.new(
            make: 'Mini',
            model: 'Cooper',
            year: '2015',
            additional_information: '1.5 F55 Salt',
            image_url: 'fotos_tu_carro/mini_apr.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-608856291-mini-cooper-salt-15t-mt-_JM#position=34&type=item&tracking_id=eab9705a-4579-41cb-a2b6-d7a5a2587946'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
