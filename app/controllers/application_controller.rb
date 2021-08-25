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
            make: 'Porsche',
            model: 'Cayenne',
            year: '2014',
            additional_information: '3.0 Comfort Dieselau',
            image_url: 'fotos_tu_carro/aug_porsche.jpg',
            #showcase_video_url: 'https://youtu.be/EKyFdyOHw9w',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-656050497-porsche-cayenne-2014-30-comfort-diesel-_JM#position=9&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase A',
            year: '2018',
            additional_information: 'A200 1.6 Urban',
            image_url: 'fotos_tu_carro/july_mercedes_a200.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-637647549-mercedes-benz-_JM#position=13&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
        CarInformation.new(
            make: 'Nissan',
            model: 'Kicks',
            year: '2018',
            additional_information: '1.6 Sense',
            image_url: 'fotos_tu_carro/aug_nissan.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-652660070-nissan-kicks-2018-16-sense-_JM#position=13&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 2',
            year: '2019',
            additional_information: '3.0 M240i F22 Coupe',
            image_url: 'fotos_tu_carro/july_bmw_serie2.jpg',
            #showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-637642917-bmw-serie-2-30-m240i-f22-coupe-_JM#position=14&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
    ]

    @slide2_cars = [
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 3',
            year: '2012',
            additional_information: '2.5 325i E93 Cabriolet',
            image_url: 'fotos_tu_carro/aug_bmw2012.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-658666878-bmw-serie-325-cabriolet-convertible-_JM#position=23&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
        CarInformation.new(
            make: 'Mazda',
            model: '3',
            year: '2021',
            additional_information: '2.0 Grand Touring Lx',
            image_url: 'fotos_tu_carro/aug_mazda3.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-657553299-mazda-3-_JM#position=28&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 2',
            year: '2018',
            additional_information: '1.5 218i F45 Active Tourer',
            image_url: 'fotos_tu_carro/aug_bmw_serie2.jpg',
            #showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-656229127-bmw-serie-2-218i-f45-active-tourer-2018-_JM#position=29&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
        CarInformation.new(
            make: 'Nissan',
            model: 'Qashqai',
            year: '2015',
            additional_information: '+2',
            image_url: 'fotos_tu_carro/july_nissan.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-623914730-nissan-qashqai-2-_JM#position=25&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
    ]
    @slide3_cars = [
        CarInformation.new(
            make: 'Mini',
            model: 'Countryman',
            year: '2020',
            additional_information: '2.0 F60 Cooper S Chili',
            image_url: 'fotos_tu_carro/july_mini_countryman.jpg',
            #showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-641975182-mini-countryman-2020-20-f60-cooper-s-chili-all4-_JM#position=33&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase E',
            year: '2016',
            additional_information: '2.0 Cgi 184 hp',
            image_url: 'fotos_tu_carro/aug_mercedes_2016.jpg',
            #showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-655301004-mercedes-benz-e200-advangarde-_JM#position=31&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 4',
            year: '2018',
            additional_information: '420i Gran Coupe',
            image_url: 'fotos_tu_carro/july_bmw420.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-633981087-bmw-serie-4-420i-gran-coupe-_JM#position=20&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
        CarInformation.new(
            make: 'Volkswagen',
            model: 'Jetta',
            year: '2015',
            additional_information: '2.5 Highline',
            image_url: 'fotos_tu_carro/aug_jetta.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-651885268-volkswagen-new-jetta-highline-tp-_JM#position=34&search_layout=grid&type=item&tracking_id=31b5dffc-265b-4645-b0c9-a2c4c50d4fcd'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Ford',
            model: 'Edge',
            year: '2017',
            additional_information: '3.5 Sel',
            image_url: 'fotos_tu_carro/aug_ford.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-657556006-ford-edge-_JM#position=3&search_layout=grid&type=item&tracking_id=9c983b69-c1ad-41db-9541-d0d0e5280b8b'
        ),
        CarInformation.new(
            make: 'Jeep',
            model: 'Compass',
            year: '2014',
            additional_information: '2.4 Limited',
            image_url: 'fotos_tu_carro/aug_jeep.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-656935050-jeep-compass-_JM#position=5&search_layout=grid&type=item&tracking_id=9c983b69-c1ad-41db-9541-d0d0e5280b8b'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'I3',
            year: '2020',
            additional_information: '',
            image_url: 'fotos_tu_carro/july_bmw_i3.jpg',
            #showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-615927715-bmw-i3-_JM#position=47&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
        CarInformation.new(
            make: 'Nissan',
            model: 'X Trail',
            year: '2018',
            additional_information: '2.5 Advance',
            image_url: 'fotos_tu_carro/july_nissan_xtrail.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-639662969-nissan-xtrail-_JM#position=9&search_layout=grid&type=item&tracking_id=47502ad9-d04e-4d7f-9ac3-afcf14d188fb'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
