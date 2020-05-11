class Car
  include ActiveModel::Model
  attr_accessor :make, :model, :year, :additional_information, :image_url, :showcase_video_url, :tu_carro_url

  validates_presence_of :make, :model, :year, :additional_information, :image_url, :showcase_video_url, :tu_carro_url
end