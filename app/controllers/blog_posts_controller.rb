class BlogPostsController < ApplicationController

  skip_before_action :authenticate_user!

  def index

    set_meta_tags title: 'Blog - Retomautos',
                  description: 'Este Blog nace de nuestra pasión por los carros. Encontrarás informació sobre diferentes marcas que te ayudarán a entender más sobre cada uno de sus carros',
                  keywords: 'blog carros'

    @blog_posts = [
      BlogPost.new(
          blog_title: 'Bienvenido al mundo de BMW',
          card_text:  'BMW cuenta con un lenguaje de siglas para identificar cada uno de sus vehículos. Pero, ¿cómo identificarlos? ¿Cuál es la diferencia entre un 120i y un 530d?',
          card_link:  blog_posts_bienvenido_al_mundo_de_bmw_path, # => '/blog_posts/bienvenido_al_mundo_de_bmw'
          blog_image: 'blog_photos/bienvenido_bmw.jpg'
      ),
      BlogPost.new(
          blog_title: 'Automóviles BMW',
          card_text: 'Desde el Serie 1 al Serie 8, BMW usa esta nomenclatura para identificar la carrocería de cada uno de sus automóviles.',
          card_link: blog_posts_las_series_de_bmw_path,
          blog_image: 'fotos_tu_carro/bmw_420gc.jpg'
      ),
      BlogPost.new(
          blog_title: 'Las Camionetas de BMW',
          card_text: 'A partir del año 2000, BMW entró en la era de las SUV (Sport Utility Vehicle), más conocidas como camionetas. Para diferenciar este tipo de vehículos BMW utilizó la letra X.',
          card_link: blog_posts_las_camionetas_de_bmw_path,
          blog_image: 'fotos_tu_carro/bmw_420gc.jpg'
      ),
      BlogPost.new(
          blog_title: 'Los Roadster de BMW',
          card_text: 'BMW tiene una línea especial de roadster, vehículos deportivos convertibles para 2 pasajeros. Estos, son identificados por la letra Z.',
          card_link: blog_posts_los_roadster_de_bmw_path,
          blog_image: 'fotos_tu_carro/bmw_420gc.jpg'
      ),

      BlogPost.new(
          blog_title: 'Los Motores de BMW',
          card_text: 'La nomenclatura que identifica los vehículos de BMW está compuesta por 3 números. El primer número hace referencia a la carrocería, y los últimos dos hacen referencia al motor que tiene.',
          card_link: blog_posts_los_motores_de_bmw_path,
          blog_image: 'fotos_tu_carro/bmw_420gc.jpg'
      ),
      BlogPost.new(
          blog_title: 'Los deportivos de BMW',
          card_text: 'BMW cuenta con una línea especial de vehículos deportivos, los cuales hacen parte de la división BMW Motorsport, y utilizan la letra M para diferenciarse del resto de vehículos de la marca.',
          card_link: blog_posts_los_deportivos_de_bmw_path,
          blog_image: 'fotos_tu_carro/bmw_420gc.jpg'
      ),
    ]
    # TODO: SEO meta tags
  end

  def bienvenido_al_mundo_de_bmw
    set_meta_tags title: 'El mundo de BMW',
                  description: 'BMW cuenta con un lenguaje de siglas para identificar cada uno de sus vehículos. Pero, ¿cómo identificarlos? ¿Cuál es la diferencia entre un 120i y un 530d?',
                  keywords: 'BMW siglas numeros'
  end

  def las_series_de_bmw
    set_meta_tags title: 'Los Automóviles de BMW',
                  description: 'Desde el Serie 1 al Serie 8, BMW usa esta nomenclatura para identificar la carrocería de cada uno de sus automóviles.',
                  keywords: 'bmw serie 1 serie 2 serie 3 serie 4 serie 5 serie 6 serie 7 serie 8'
  end
  def las_camionetas_de_bmw
    set_meta_tags title: 'Las camionetas de BMW',
                  description: 'A partir del año 2000, BMW entró en la era de las SUV (Sport Utility Vehicle), más conocidas como camionetas. Para diferenciar este tipo de vehículos BMW utilizó la letra X.',
                  keywords: 'bmw suv camioneta x1 x2 x3 x4 x5 x6 x7'
  end
  def los_roadster_de_bmw
    set_meta_tags title: 'Los Roadster de BMW',
                  description: 'BMW tiene una línea especial de roadster, vehículos deportivos convertibles para 2 pasajeros. Estos, son identificados por la letra Z.',
                  keywords: 'bmw roadster deportivo z3 z4 convertible'
  end
  def los_motores_de_bmw
    set_meta_tags title: 'Los Motores de BMW',
                  description: 'La nomenclatura que identifica los vehículos de BMW está compuesta por 3 números. El primer número hace referencia a la carrocería, y los últimos dos hacen referencia al motor que tiene.',
                  keywords: 'bmw motores'
  end
  def los_deportivos_de_bmw
    set_meta_tags title: 'Los Deportivos de BMW',
                  description: 'BMW cuenta con una línea especial de vehículos deportivos, los cuales hacen parte de la división BMW Motorsport, y utilizan la letra M para diferenciarse del resto de vehículos de la marca.',
                  keywords: 'bmw deportivo motorsport m3 m4 m'
  end
end
