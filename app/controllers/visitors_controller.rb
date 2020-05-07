class VisitorsController < ApplicationController
  def home
    set_meta_tags title: 'Carros usados Bogotá',
                  description: 'Encuentra una amplia selección de carros usados a precios muy competitivos, con facilidad de financiación, agilidad en los trámites y compra segura.',
                  keywords: 'Carros usados'
  end

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
