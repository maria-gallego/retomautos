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
            model: 'i3',
            year: '2019',
            additional_information: 'Suite 94ah 170hp',
            image_url: 'fotos_tu_carro/dec_bmw_i3.jpg',
            #showcase_video_url: 'https://youtu.be/EKyFdyOHw9w',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-583850874-bmw-i3-suite-94ah-170hp-_JM#position=5&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Porsche',
            model: '911 Carrera',
            year: '2006',
            additional_information: '4s Mt Cabriolet Convertible',
            image_url: 'fotos_tu_carro/dec_porsche.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-583229581-porsche-911-carrera-4s-mt-cabriolet-convertible-_JM#position=6&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 4 420i',
            year: '2018',
            additional_information: 'Cabriolet Convertible',
            image_url: 'fotos_tu_carro/dec_bmw_420.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-587083281-bmw-serie-4-420i-cabriolet-convertible-_JM#position=9&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase A A 45',
            year: '2015',
            additional_information: 'AMG 4 Matic',
            image_url: 'fotos_tu_carro/dec_mercedes_a45.jpg',
            #showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-586172002-mercedes-benz-clase-a-a-45-amg-4-matic-_JM#position=10&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
    ]

    @slide2_cars = [
        CarInformation.new(
            make: 'Renault',
            model: 'Twizy',
            year: '2016',
            additional_information: 'Sin Pico y Placa',
            image_url: 'fotos_tu_carro/dec_renault_twizy.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-595371726-renault-twizy-10000-km-sin-pico-y-placa-_JM#position=13&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'GLA 200',
            year: '2018',
            additional_information: 'Urban',
            image_url: 'fotos_tu_carro/dec_mercedes_gla.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-590155899-mercedes-benz-gla-200-urban-_JM#position=14&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'M4',
            year: '2019',
            additional_information: 'Premium',
            image_url: 'fotos_tu_carro/dec_bmw_m4.jpg',
            #showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-576725716-bmw-m4-premiun-_JM#position=15&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Chevrolet',
            model: 'Cruze',
            year: '2012',
            additional_information: '1.8 Mt Nickel',
            image_url: 'fotos_tu_carro/dec_chevrolet.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-597454165-chevrolet-cruze-18-mt-nickel-_JM#position=18&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
    ]
    @slide3_cars = [
        CarInformation.new(
            make: 'Mini Cooper',
            model: 'S Countryman',
            year: '2016',
            additional_information: '1.6 Tp',
            image_url: 'fotos_tu_carro/dec_minicooper.jpg',
            #showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-597453915-mini-cooper-s-countryman-16-tp-_JM#position=19&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Mazda',
            model: '3 Touring',
            year: '2019',
            additional_information: '2.0 Tp',
            image_url: 'fotos_tu_carro/dec_mazda3.jpg',
            #showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-596166270-mazda-mazda-3-touring-20-tp-_JM#position=22&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 3 320d',
            year: '2015',
            additional_information: 'Sport Tp',
            image_url: 'fotos_tu_carro/dec_bmw320.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-595980193-bmw-serie-3-320d-sport-tp-_JM#position=23&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'X4',
            year: '2018',
            additional_information: 'Xdrive 20d',
            image_url: 'fotos_tu_carro/dec_bmwx4.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-595354549-bmw-x4-xdrive-20d-_JM#position=24&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase C C 180',
            year: '2016',
            additional_information: 'Tp',
            image_url: 'fotos_tu_carro/dec_mercedes_c180.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-593680571-mercedes-benz-clase-c-180-tp-_JM#position=25&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Ford',
            model: 'Fiesta',
            year: '2015',
            additional_information: 'Se Hb 1.6 Tp',
            image_url: 'fotos_tu_carro/dec_ford_fiesta.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-596802056-ford-fiesta-se-hb-16-tp-_JM#position=31&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'Mazda',
            model: '3 Grand Touring',
            year: '2019',
            additional_information: '2.0 Lx Tp',
            image_url: 'fotos_tu_carro/dec_maxda3_grandtouring.jpg',
            #showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-591762886-mazda-mazda-3-grand-touring-20-lx-tp-_JM#position=32&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'M 240i Cabrio',
            year: '2018',
            additional_information: 'Tp Convertible',
            image_url: 'fotos_tu_carro/dec_bmw_cabrio.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-595978801-bmw-m240i-cabrio-tp-convertible-_JM#position=42&type=item&tracking_id=135c9396-9a49-4fa1-af20-43c891133a9d'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
