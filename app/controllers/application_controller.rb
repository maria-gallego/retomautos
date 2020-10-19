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
            year: '2020',
            additional_information: 'i3S 181 cc',
            image_url: 'fotos_tu_carro/bmw_i3.jpg',
            showcase_video_url: 'https://youtu.be/EKyFdyOHw9w',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-567975385-bmw-i3s-_JM#position=16&type=item&tracking_id=2ec92fff-5e7d-49e4-b26f-513d4fa73dd2'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'M240i',
            year: '2017',
            additional_information: '3.0 Tp',
            image_url: 'fotos_tu_carro/bmw_m240_2017.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-575826659-bmw-m240i-30-tp-_JM#position=6&type=item&tracking_id=bd8c0f27-5bfe-4b18-b8ee-1f41f2f16992'
        ),
        CarInformation.new(
            make: 'Volkswagen',
            model: 'Tiguan',
            year: '2018',
            additional_information: 'Trendline 1.4 Tp',
            image_url: 'fotos_tu_carro/tiguan.jpg',
            showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-564053675-volkswagen-tiguan-trendline-14-tp-_JM#position=2&type=item&tracking_id=e83e9826-c437-411c-8ac1-a0ff9a40f441'
        ),
        CarInformation.new(
            make: 'BMW',
            model: '420',
            year: '2018',
            additional_information: 'Gran Coupe Sport',
            image_url: 'fotos_tu_carro/bmw_420.jpg',
            showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-550816167-bmw-420-gran-coupe-sport-_JM#position=9&type=item&tracking_id=e7f80674-6164-4539-b635-8dda9f7d4938'
        ),
    ]

    @slide2_cars = [
        CarInformation.new(
            make: 'Volkswagen',
            model: 'Golf Highline',
            year: '2018',
            additional_information: '1.4t Dsg',
            image_url: 'fotos_tu_carro/vw_golf_2018.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-582413381-volkswagen-golf-highline-14t-dsg-_JM#position=42&type=item&tracking_id=fd633cc5-cde5-48e4-987f-029c55ab4b96'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'C 180',
            year: '2018',
            additional_information: 'Tp',
            image_url: 'fotos_tu_carro/mercedes_c180_2018.jpg',
            showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-568301063-mercedes-benz-c-180-tp-_JM#position=7&type=item&tracking_id=7fb15419-960c-478b-8a44-efa5a56c31db'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 3',
            year: '2020',
            additional_information: '330i Tp',
            image_url: 'fotos_tu_carro/bmw_330_2020.jpg',
            #showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-575380830-bmw-serie-3-330i-tp-_JM#position=3&type=item&tracking_id=fd633cc5-cde5-48e4-987f-029c55ab4b96'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'M4',
            year: '2019',
            additional_information: 'Premium',
            image_url: 'fotos_tu_carro/bmw_m4_2019.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-576725716-bmw-m4-premiun-_JM#position=22&type=item&tracking_id=bd8c0f27-5bfe-4b18-b8ee-1f41f2f16992'
        ),
    ]
    @slide3_cars = [
        CarInformation.new(
            make: 'BMW',
            model: 'X1',
            year: '2018',
            additional_information: 'Sdrive 18d',
            image_url: 'fotos_tu_carro/bmw_x1_2018.jpg',
            #showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-570312878-bmw-x1-sdrive-18d-_JM#position=10&type=item&tracking_id=fd633cc5-cde5-48e4-987f-029c55ab4b96'
        ),
        CarInformation.new(
            make: 'Jeep',
            model: 'Renegade Limited',
            year: '2017',
            additional_information: '2.4 4x4 Tp',
            image_url: 'fotos_tu_carro/jeep_2017.jpg',
            showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-567106874-jeep-renegade-limited-24-4x4-tp-_JM#position=1&type=item&tracking_id=a8d19dbc-3fa3-4a98-bd47-e5ddb75c8727'
        ),
        CarInformation.new(
            make: 'Audi',
            model: 'Q5',
            year: '2014',
            additional_information: 'Luxury 2.0 Tp',
            image_url: 'fotos_tu_carro/audi_q5_2014.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-580603999-audi-q5-20t-luxury-quattro-s-tronic-_JM#position=17&type=item&tracking_id=fd633cc5-cde5-48e4-987f-029c55ab4b96'
        ),
        CarInformation.new(
            make: 'Hyundai',
            model: 'Tucson',
            year: '2015',
            additional_information: 'Ix 35 2.0 Mt',
            image_url: 'fotos_tu_carro/hyundai_tucson_2015.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-573286989-hyundai-tucson-ix-35-20-mt-_JM#position=14&type=item&tracking_id=bd8c0f27-5bfe-4b18-b8ee-1f41f2f16992'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Mazda',
            model: '3',
            year: '2019',
            additional_information: 'Touring Tp',
            image_url: 'fotos_tu_carro/mazda_3_2019.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-569175343-mazda-3-touring-tp-_JM#position=18&type=item&tracking_id=fd633cc5-cde5-48e4-987f-029c55ab4b96'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'A 200',
            year: '2018',
            additional_information: 'Urban Tp',
            image_url: 'fotos_tu_carro/mercedes_a200.jpg',
            showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-554043664-mercedes-benz-clase-a-a-200-tp-urban-_JM#position=3&type=item&tracking_id=be2e143c-311b-4311-853b-83b959595e4b'
        ),
        CarInformation.new(
            make: 'BMW',
            model: '330i',
            year: '2017',
            additional_information: 'Luxury',
            image_url: 'fotos_tu_carro/bmw_330_2017.jpg',
            showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-550470239-bmw-330-luxuri-_JM#position=5&type=item&tracking_id=a05fd153-e203-4d47-9193-836431d7c84e'
        ),
        CarInformation.new(
            make: 'Mercedes Benz',
            model: 'Clase A',
            year: '2020',
            additional_information: 'A 200 Sedan',
            image_url: 'fotos_tu_carro/mercedes_benz_a200.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-575380361-mercedes-benz-clase-a-a-200-sedan-_JM#position=43&type=item&tracking_id=bd8c0f27-5bfe-4b18-b8ee-1f41f2f16992'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
