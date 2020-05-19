class BlogPostsController < ApplicationController
  def index
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
    # TODO: SEO meta tags
  end

  def las_series_de_bmw
    # TODO: SEO meta tags
  end
  def las_camionetas_de_bmw
    # TODO: SEO meta tags
  end
  def los_roadster_de_bmw
    # TODO: SEO meta tags
  end
  def los_motores_de_bmw
    # TODO: SEO meta tags
  end
  def los_deportivos_de_bmw
    # TODO: SEO meta tags
  end
end
