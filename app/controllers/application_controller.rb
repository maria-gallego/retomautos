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
            make: 'BMW',
            model: 'M4',
            year: '2019',
            additional_information: 'Premium',
            image_url: 'fotos_tu_carro/bmw_m4_jan.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-576725716-bmw-m4-premium-_JM#position=2&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase A | A 45',
            year: '2015',
            additional_information: 'AMG 4 Matic',
            image_url: 'fotos_tu_carro/jan_mercedes_a45.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-586172002-mercedes-benz-clase-a-a-45-amg-4-matic-_JM#position=4&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase A A 45',
            year: '2016',
            additional_information: 'AMG 4 Matic',
            image_url: 'fotos_tu_carro/jan_mercedes_2016.jpg',
            #showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-593334864-mercedes-benz-clase-a-a-45-amg-4matic-_JM#position=3&type=item&tracking_id=f76ee3b9-039b-4d85-9d36-a8a1b91cdbb9'
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
            model: 'SLK 200',
            year: '2016',
            additional_information: 'Carbon Edition',
            image_url: 'fotos_tu_carro/jan_mercedes_slk.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-603568987-mercedes-benz-slk-200-carbon-edition-_JM#position=14&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
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
            make: 'Mini',
            model: 'Cooper',
            year: '2016',
            additional_information: '1.5 Salt Tp',
            image_url: 'fotos_tu_carro/jan_mini_salt.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-602541885-mini-cooper-15-salt-tp-_JM#position=18&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
        ),
    ]
    @slide3_cars = [
        CarInformation.new(
            make: 'BMW',
            model: 'X5 Xdrive 40i',
            year: '2020',
            additional_information: '7 Pasajeros',
            image_url: 'fotos_tu_carro/jan_bmw_x5.jpg',
            #showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-602181656-bmw-x5-xdrive-40i-7-pasajeros-suspencion-neumatica-_JM#position=20&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
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
            make: 'Nissan',
            model: 'Note',
            year: '2014',
            additional_information: 'Sense 1.6 Tp',
            image_url: 'fotos_tu_carro/jan_nissan.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-595423057-nissan-note-sense-16-tp-_JM#position=27&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Mini',
            model: 'Cooper',
            year: '2019',
            additional_information: '1.5 Tp John Cooper Works',
            image_url: 'fotos_tu_carro/jan_mini_johncooper.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-602791564-mini-cooper-15-tp-paquete-jonh-cooper-works-_JM#position=16&type=item&tracking_id=f76ee3b9-039b-4d85-9d36-a8a1b91cdbb9'
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
            make: 'Mercedes Benz',
            model: 'Clase C | C 180',
            year: '2016',
            additional_information: 'Tp',
            image_url: 'fotos_tu_carro/jan_mercedes_c180.jpg',
            #showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-599546388-mercedes-benz-clase-c-180-tp-_JM#position=35&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
        ),
        CarInformation.new(
            make: 'Nissan',
            model: 'Sentra',
            year: '2015',
            additional_information: 'Sens Automático',
            image_url: 'fotos_tu_carro/jan_nissan_sentra.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-604974266-nissan-sentra-sens-automatico-_JM#position=39&type=item&tracking_id=a91f772e-a2b9-40fd-b778-79c0f4c61e59'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
