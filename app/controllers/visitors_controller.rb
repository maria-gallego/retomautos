class VisitorsController < ApplicationController
  def home
    set_meta_tags title: 'Carros usados Bogotá',
                  description: 'Encuentra una amplia selección de carros usados a precios muy competitivos, con facilidad de financiación, agilidad en los trámites y compra segura.',
                  keywords: 'Carros usados'

    set_meta_tags og: {
        title:    'Retomautos | Carros usados Bogotá',
        url:      'www.retomautos.com',
        image:    'app/assets/images/logo_retomautos.jpeg',
    }

    # Slides 'Nuestros Carros' - Home
    @slide1_cars = [
        Car.new(
            make: 'BMW',
            model: 'M4',
            year: '2018',
            additional_information: 'Coupé',
            image_url: 'fotos_tu_carro/bmw_m4.jpg',
            showcase_video_url: 'https://youtu.be/HsbGWNgqYyU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-548164801-bmw-m4-coupe-_JM#position=4&type=item&tracking_id=e7f80674-6164-4539-b635-8dda9f7d4938'
        ),
        Car.new(
            make: 'BMW',
            model: '320i',
            year: '2018',
            additional_information: 'Serie 3 Tp',
            image_url: 'fotos_tu_carro/bmw_320.jpg',
            showcase_video_url: 'https://youtu.be/K2oMA1MPTX8',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-555407286-bmw-serie-3-320i-tp-2018-_JM#position=17&type=item&tracking_id=8e94058b-2807-49d3-a4ac-f345d3245c10'
        ),
        Car.new(
            make: 'BMW',
            model: 'X2',
            year: '2019',
            additional_information: 'S Drive 20i M Sport',
            image_url: 'fotos_tu_carro/bmwx2.jpg',
            showcase_video_url: 'https://www.youtube.com/watch?v=ZYsyoa3X7Ws',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-548413953-bmw-x2-sdrive-20i-m-sport-_JM#position=2&type=item&tracking_id=e7f80674-6164-4539-b635-8dda9f7d4938'
        ),
        Car.new(
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
        Car.new(
            make: 'Mercedes Benz',
            model: 'GLE 500',
            year: '2019',
            additional_information: '4 Matic',
            image_url: 'fotos_tu_carro/mercedes_gle.jpg',
            showcase_video_url: 'https://youtu.be/UWwPdaiXWq4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-556780452-mercedez-benz-gle-500-4matic-2019-_JM#position=4&type=item&tracking_id=be2e143c-311b-4311-853b-83b959595e4b'
        ),
        Car.new(
            make: 'Chevrolet',
            model: 'Camaro',
            year: '2017',
            additional_information: 'SS 6.2',
            image_url: 'fotos_tu_carro/camaro.jpg',
            showcase_video_url: 'https://youtu.be/3V22pfjFX7c',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-562622229-chevrolet-camaro-ss-62-_JM#position=19&type=item&tracking_id=15ebec6c-38cb-4d22-ba20-16b178483a09'
        ),
        Car.new(
            make: 'Mini Cooper',
            model: 'S',
            year: '2018',
            additional_information: '5P TP',
            image_url: 'fotos_tu_carro/mini_s_2018.jpg',
            showcase_video_url: 'https://youtu.be/Vhl3agDmOXU',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-550476704-mini-couper-s-5p-tp-_JM#position=1&type=item&tracking_id=7d60640e-1787-484c-8ea3-53ddead4faae'
        ),
        Car.new(
            make: 'Mercedes Benz',
            model: 'B 180',
            year: '2018',
            additional_information: '1.6 Tp',
            image_url: 'fotos_tu_carro/mercedes_b180.jpg',
            showcase_video_url: 'https://youtu.be/7Kw0SXlk64Y',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-555089637-mercedez-benz-b180-16-tp-2018-_JM#position=2&type=item&tracking_id=be2e143c-311b-4311-853b-83b959595e4b'
        ),
    ]
    @slide3_cars = [
        Car.new(
            make: 'Kia',
            model: 'New Sportage',
            year: '2017',
            additional_information: 'Revolution Lx 2.0',
            image_url: 'fotos_tu_carro/kia_ns.jpg',
            showcase_video_url: 'https://youtu.be/3SX8oy82mYQ',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-554725392-kia-new-sportage-revolution-lx-20-2017-_JM#position=23&type=item&tracking_id=359e6f5d-cd22-42ef-b34f-fce5fc972914'
        ),
        Car.new(
            make: 'BMW',
            model: '420i',
            year: '2017',
            additional_information: 'Grand Coupe M',
            image_url: 'fotos_tu_carro/bmw_420gc.jpg',
            showcase_video_url: 'https://youtu.be/ka948ui0Zxc',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-548184915-bmw-serie-4-420i-grand-coupe-m-2017-_JM#position=3&type=item&tracking_id=a05fd153-e203-4d47-9193-836431d7c84e'
        ),
        Car.new(
            make: 'Mini Cooper',
            model: '1.5',
            year: '2015',
            additional_information: 'AT',
            image_url: 'fotos_tu_carro/mini_1.5.jpg',
            showcase_video_url: 'https://youtu.be/3Ardo2NiEWE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-554724896-mini-cooper-tp-15-2015-_JM#position=2&type=item&tracking_id=7d60640e-1787-484c-8ea3-53ddead4faae'
        ),
        Car.new(
            make: 'Mazda',
            model: '6',
            year: '2015',
            additional_information: 'Grand Touring LX TP',
            image_url: 'fotos_tu_carro/mazda6_2015.jpg',
            showcase_video_url: 'https://youtu.be/esagFIIoVNM',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-552224198-mazda-6-grand-touring-lx-tp-_JM#position=7&type=item&tracking_id=359e6f5d-cd22-42ef-b34f-fce5fc972914'
        ),
    ]

    @slide4_cars = [
        Car.new(
            make: 'BMW',
            model: '218i',
            year: '2019',
            additional_information: 'Active Tourer Sport',
            image_url: 'fotos_tu_carro/bmw_218.jpg',
            showcase_video_url: 'https://youtu.be/et57692P4NE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-554889832-bmw-serie-2-218i-active-tourer-sport-2019-_JM#position=8&type=item&tracking_id=a05fd153-e203-4d47-9193-836431d7c84e'
        ),
        Car.new(
            make: 'Mercedes Benz',
            model: 'A 200',
            year: '2018',
            additional_information: 'Urban Tp',
            image_url: 'fotos_tu_carro/mercedes_a200.jpg',
            showcase_video_url: 'https://youtu.be/HxkPxiIxgso',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-554043664-mercedes-benz-clase-a-a-200-tp-urban-_JM#position=3&type=item&tracking_id=be2e143c-311b-4311-853b-83b959595e4b'
        ),
        Car.new(
            make: 'BMW',
            model: '330i',
            year: '2017',
            additional_information: 'Luxury',
            image_url: 'fotos_tu_carro/bmw_330_2017.jpg',
            showcase_video_url: 'https://youtu.be/beoCQ5K1ays',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-550470239-bmw-330-luxuri-_JM#position=5&type=item&tracking_id=a05fd153-e203-4d47-9193-836431d7c84e'
        ),
        Car.new(
            make: 'BMW',
            model: 'X3',
            year: '2015',
            additional_information: 'Xdrive 28i Tp',
            image_url: 'fotos_tu_carro/bmw_x3_2015.jpg',
            showcase_video_url: 'https://youtu.be/zN40lU_rI_U',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-555408559-bmw-x3-xdrive-28i-tp-_JM#position=10&type=item&tracking_id=a05fd153-e203-4d47-9193-836431d7c84e'
        ),
    ]
  end
  # End Slides 'Nuestros Carros' - Home

  def financing
    set_meta_tags title: 'Financiación',
                  description: 'Ofrecemos facilidad de financiacion. Contacta a nuestros aliados para evaluar las mejores opciones de financiacion.',
                  keywords: 'Financiación, crédito'
  end

  def about_us
    set_meta_tags title: 'Sobre Nosotros',
                  description: 'Somos una empresa con más de 18 años de experiencia en el mercado de carros usados. Ofrecemos una amplia selección de carros de gama media y alta.',
                  keywords: 'sobre'
  end
end
