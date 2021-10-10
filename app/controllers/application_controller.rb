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
            make: 'Renault',
            model: 'Koleos',
            year: '2010',
            additional_information: '2.5 Privilege',
            image_url: 'fotos_tu_carro/oct-koleos.jpg',
            #showcase_video_url: 'https://youtu.be/EKyFdyOHw9w',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-819393637-renault-_JM#position=45&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Porsche',
            model: 'Cayenne',
            year: '2014',
            additional_information: '3.0 Comfort Diesel',
            image_url: 'fotos_tu_carro/oct-porsche.jpg',
            #showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-807272240-porsche-cayenne-2014-30-comfort-diesel-_JM#position=44&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Bmw',
            model: 'G310',
            year: '2019',
            additional_information: '',
            image_url: 'fotos_tu_carro/oct-bmw-g310.jpg',
            #showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-802186184-bmw-g310-_JM#position=41&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Renault',
            model: 'Twizy',
            year: '2016',
            additional_information: 'Technic',
            image_url: 'fotos_tu_carro/oct-twizy.jpg',
            #showcase_video_url: 'https://youtu.be/v82WhZDuTcM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-654907507-renault-twizy-_JM#position=38&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
    ]

    @slide2_cars = [
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 4',
            year: '2016',
            additional_information: '420i 2.0 F33',
            image_url: 'fotos_tu_carro/oct-bmw420.jpg',
            #showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-656052651-bmw-serie-4-2016-20-420i-f33-cabriolet-executive-_JM#position=31&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'Serie 2',
            year: '2018',
            additional_information: '1.5 218i F45 Active Tourer',
            image_url: 'fotos_tu_carro/oct-bmwserie2.jpg',
            #showcase_video_url: 'https://youtu.be/cirpdZirAmU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-656229127-bmw-serie-2-218i-f45-active-tourer-2018-_JM#position=30&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'BMW',
            model: 'i3',
            year: '2015',
            additional_information: 'Loft',
            image_url: 'fotos_tu_carro/oct-bmw-i3.jpg',
            #showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-658352134-bmw-i3-_JM#position=28&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Renault',
            model: 'Captur',
            year: '2017',
            additional_information: '2.0 Zen Mecán',
            image_url: 'fotos_tu_carro/ict-renault-captur.jpg',
            #showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-800657305-renault-captur-_JM#position=27&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
    ]
    @slide3_cars = [
        CarInformation.new(
            make: 'Mercedes-Benz',
            model: 'Clase E',
            year: '2019',
            additional_information: '2.0',
            image_url: 'fotos_tu_carro/oct-mercedes-clasee.jpg',
            #showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-806451018-mercedes-benz-clase-e-2019-20-exclusive-_JM#position=15&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Subaru',
            model: 'Xv 2.0-s',
            year: '2019',
            additional_information: 'Es Cvt Eyesight',
            image_url: 'fotos_tu_carro/oct-subary.jpg',
            #showcase_video_url: 'https://youtu.be/R4QJBnH-VYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-803472666-subaru-xv-20-s-es-cvt-eyesight-_JM#position=18&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Jeep',
            model: 'Cherokee',
            year: '2014',
            additional_information: '3.2 Longitude',
            image_url: 'fotos_tu_carro/oct-jeep.jpg',
            #showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-812937124-jeep-cherokee-2014-32-longitude-_JM#position=10&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Ford',
            model: 'Focus',
            year: '2014',
            additional_information: '2.0 Titanium',
            image_url: 'fotos_tu_carro/oct-fordfocus.jpg',
            #showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-811134560-ford-focus-2014-20-titanium-_JM#position=12&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
    ]

    @slide4_cars = [
        CarInformation.new(
            make: 'Ford',
            model: 'Explorer',
            year: '2013',
            additional_information: '3.5 Limited',
            image_url: 'fotos_tu_carro/oct-fordexplorer.jpg',
            #showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-817063143-ford-explorer-2013-35-limited-_JM#position=7&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Nissan',
            model: 'X-Trail',
            year: '2020',
            additional_information: '2.5 Advance',
            image_url: 'fotos_tu_carro/oct-nissan-xtrail.jpg',
            #showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-817189497-nissan-x-trail-2020-25-advance-_JM#position=6&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Mazda',
            model: '3',
            year: '2020',
            additional_information: '2.0 Touring',
            image_url: 'fotos_tu_carro/oct-mazda3.jpg',
            #showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-817601623-mazda-3-2020-_JM#position=3&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
        CarInformation.new(
            make: 'Ford',
            model: 'Escape',
            year: '2014',
            additional_information: '2.0 Se 4x4',
            image_url: 'fotos_tu_carro/oct-fordescape.jpg',
            #showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-818935114-ford-escape-_JM#position=2&search_layout=grid&type=item&tracking_id=6feea92b-5b39-467d-b0d2-74b46dcfc453'
        ),
    ]

  end

  def user_not_authorized
    flash[:alert] = "No Autorizado."
    redirect_to (request.referrer || root_path)
  end
end
