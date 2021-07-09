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
            make: 'BMW',
            model: 'M4 3.0',
            year: '2018',
            additional_information: 'F82 Coupe Performance',
            image_url: 'fotos_tu_carro/july_m4.jpg',
            #showcase_video_url: 'https://youtu.be/EKyFdyOHw9w',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-636612704-bmw-m4-30-m4-f82-coupe-performance-_JM#position=15&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
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
            make: 'Volkswagen',
            model: 'Tiguan',
            year: '2018',
            additional_information: 'Allspace Trendline 2.0 Tsi 4motion',
            image_url: 'fotos_tu_carro/july_tiguan.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-635210392-volkswagen-tiguan-_JM#position=17&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
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
            make: 'Mercedes Benz',
            model: 'GLA',
            year: '2015',
            additional_information: '1.6',
            image_url: 'fotos_tu_carro/july_mercedes_gla.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-639992419-mercedes-benz-gla-200-full-equipo-_JM#position=16&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'X3',
            year: '2015',
            additional_information: 'F25 Xdrive 28i',
            image_url: 'fotos_tu_carro/july_bmw_x3.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-630265451-bmw-x3-_JM#position=21&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
        ),
        CarInformation.new(
            make: 'Audi',
            model: 'Q7',
            year: '2018',
            additional_information: '3.0 Tdi Quattro Progressive',
            image_url: 'fotos_tu_carro/july_q7.jpg',
            #showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-619397298-audi-q7-2018-30-tdi-quattro-progressive-_JM#position=26&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
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
            make: 'Volkswagen',
            model: 'Jetta',
            year: '2019',
            additional_information: '1.4 Tsi Highline',
            image_url: 'fotos_tu_carro/july_jetta.jpg',
            #showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-641976000-volkswagen-jetta-14-tsi-2019-_JM#position=32&search_layout=grid&type=item&tracking_id=03f9c5bc-66e3-4db9-8c1d-57c29f2edd81'
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
            make: 'Ford',
            model: 'Fusion',
            year: '2019',
            additional_information: '2.0 Titanium Plus',
            image_url: 'fotos_tu_carro/july_ford.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-617684374-ford-fusion-_JM#position=6&search_layout=grid&type=item&tracking_id=b49dbb28-55f1-430e-b350-f877aa1c5de0'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'GLA',
            year: '2018',
            additional_information: '1.6 Urban',
            image_url: 'fotos_tu_carro/july_mercedesgla.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-623966921-mercedes-gla-200-full-equipo-_JM#position=5&search_layout=grid&type=item&tracking_id=b49dbb28-55f1-430e-b350-f877aa1c5de0'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'X5',
            year: '2021',
            additional_information: 'Xdrive 40i',
            image_url: 'fotos_tu_carro/july_bmw_x3_2021.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-643538439-bmw-x5-xdrive-40i-_JM#position=2&search_layout=grid&type=item&tracking_id=47502ad9-d04e-4d7f-9ac3-afcf14d188fb'
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
