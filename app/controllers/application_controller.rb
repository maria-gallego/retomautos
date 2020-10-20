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
            model: 'X3',
            year: '2017',
            additional_information: 'Xdrive 30d Tp',
            image_url: 'fotos_tu_carro/bmw_x3_2017_oct.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-573286229-bmw-x3-xdrive-30d-tp-_JM#position=1&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
        ),
        CarInformation.new(
            make: 'Audi',
            model: 'A5',
            year: '2016',
            additional_information: ' Sportback 1.8 Tp',
            image_url: 'fotos_tu_carro/audi_a5_oct.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-570067668-audi-a5-sportback-18-tp-_JM#position=2&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
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
            make: 'Nissan',
            model: 'X Trail',
            year: '2017',
            additional_information: 'T32 4x4 7 Puestos',
            image_url: 'fotos_tu_carro/nissan_oct.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-586774570-nissan-x-trail-t32-4x4-7-pasajeros-_JM#position=7&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
        ),
        CarInformation.new(
            make: 'Jeep',
            model: 'Grand Cherokee',
            year: '2012',
            additional_information: 'Limited 4x4 3.6 Tp',
            image_url: 'fotos_tu_carro/jeep_gc_oct.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-588010388-jeep-grand-cherokee-limited-4x4-36-tp-_JM#position=12&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
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
            make: 'Alfa Romeo',
            model: 'Giulietta',
            year: '2012',
            additional_information: '1.4 Mt',
            image_url: 'fotos_tu_carro/alfa_romeo_oct.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-583536954-alfa-romeo-giulietta-14-mt-_JM#position=17&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'X3',
            year: '2019',
            additional_information: 'Xdrive 30i Tp',
            image_url: 'fotos_tu_carro/bmw_x3_oct.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-587086492-bmw-x3-xdrive-30i-tp-_JM#position=20&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Mazda',
            model: '3',
            year: '2018',
            additional_information: 'Grand Touring Sport Tp',
            image_url: 'fotos_tu_carro/mazda_3_oct.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-569175343-mazda-3-touring-tp-_JM#position=18&type=item&tracking_id=fd633cc5-cde5-48e4-987f-029c55ab4b96'
        ),
        CarInformation.new(
            make: 'Ford',
            model: 'Explorer',
            year: '2016',
            additional_information: 'Limited 4x4 Tp',
            image_url: 'fotos_tu_carro/ford_explorer_oct.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-589706888-ford-explorer-limited-4x4-tp-_JM#position=24&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
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
            make: 'BMW',
            model: 'Serie 4 420i',
            year: '2018',
            additional_information: 'Cabriolet Convertible',
            image_url: 'fotos_tu_carro/bmw_420_oct.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-587083281-bmw-serie-4-420i-cabriolet-convertible-_JM#position=34&type=item&tracking_id=4fe527c6-b45b-426e-9b6b-3926057811f5'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
