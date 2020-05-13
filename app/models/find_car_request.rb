class FindCarRequest
  include ActiveModel::Model
  attr_accessor :name, :email, :content, :phone, :make, :year_from, :year_to,:budget

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :make
  validates_presence_of :year_from
  validates_presence_of :year_to
  validates_presence_of :budget
  validates_format_of :email,
                      with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :content, :maximum => 500

end