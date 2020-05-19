class BlogPost
  include ActiveModel::Model
  attr_accessor :blog_title, :card_text, :card_link, :blog_image

  validates_presence_of :blog_title, :card_text, :card_link, :blog_image
end