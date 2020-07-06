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
            make: 'Volkswagen',
            model: 'Tiguan',
            year: '2018',
            additional_information: 'Trendline 1.4 Tp',
            image_url: 'fotos_tu_carro/tiguan.jpg',
            showcase_video_url: 'https://youtu.be/7I0BjKG_cCw',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-564053675-volkswagen-tiguan-trendline-14-tp-_JM#position=2&type=item&tracking_id=e83e9826-c437-411c-8ac1-a0ff9a40f441'
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
            make: 'Audi',
            model: 'A3',
            year: '2017',
            additional_information: 'Ambition 1.2 Tp',
            image_url: 'fotos_tu_carro/audi_a3_2017.jpg',
            showcase_video_url: 'https://youtu.be/39gqb-hl1Rk',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-566912920-audi-a3-12-ambittion-tp-_JM#position=2&type=item&tracking_id=c15cd097-989e-48d5-8b6b-74665f0d5413'
        ),
        Car.new(
            make: 'Ford',
            model: 'Mustang',
            year: '2017',
            additional_information: 'GT 5.0',
            image_url: 'fotos_tu_carro/mustang.jpg',
            showcase_video_url: 'https://youtu.be/Ld3XNYb62r4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-556781264-ford-mustang-gt-50-_JM#position=28&type=item&tracking_id=a0acb57d-ca94-405a-b2f0-7f645259eb05'
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
            make: 'Citroën',
            model: 'Ds3',
            year: '2012',
            additional_information: 'N3 1.6ti',
            image_url: 'fotos_tu_carro/citroen.jpg',
            showcase_video_url: 'https://youtu.be/4B5yyjFOZvE',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-566919181-citroen-ds3-16-t-mt-_JM#position=1&type=item&tracking_id=c59957b2-906f-4805-8d21-7157890f6d58'
        ),
        Car.new(
            make: 'Toyota',
            model: 'Fortuner',
            year: '2019',
            additional_information: 'SW4 4x2 2.4 Diesel',
            image_url: 'fotos_tu_carro/toyota_fortuner.jpg',
            showcase_video_url: 'https://youtu.be/3FF7d1cXlu4',
            tu_carro_url:'https://articulo.tucarro.com.co/MCO-566913785-toyota-fortuner-sw4-street-24-tp-_JM#position=1&type=item&tracking_id=30bb7bfc-61e9-498c-80f0-ff8841335d23'
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
