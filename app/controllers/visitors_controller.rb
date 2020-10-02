class VisitorsController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    set_meta_tags title: 'Carros usados Bogotá',
                  description: 'Encuentra una amplia selección de carros usados a precios muy competitivos, con facilidad de financiación, agilidad en los trámites y compra segura.',
                  keywords: 'Carros usados'

    set_meta_tags og: {
        title:    'Retomautos | Carros usados Bogotá',
        url:      'www.retomautos.com',
        image:    'app/assets/images/logo_retomautos.jpeg',
    }
    set_car_slides
    @client_with_inquiry = ClientWithInquiry.new
  end
  # End Slides 'Nuestros Carros' - Home

  def financing
    set_meta_tags title: 'Financiación',
                  description: 'Ofrecemos facilidad de financiacion. Contacta a nuestros aliados para evaluar las mejores opciones de financiacion.',
                  keywords: 'Financiación, crédito'
    @client_with_inquiry = ClientWithInquiry.new
  end

  def about_us
    set_meta_tags title: 'Sobre Nosotros',
                  description: 'Somos una empresa con más de 18 años de experiencia en el mercado de carros usados. Ofrecemos una amplia selección de carros de gama media y alta.',
                  keywords: 'sobre'
  end
end
