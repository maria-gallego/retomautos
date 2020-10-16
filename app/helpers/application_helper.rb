module ApplicationHelper

  def format_datetime(datetime)
    datetime.strftime("%d %b %C, %l:%M %P")
  end

  def format_date(datetime)
    datetime.strftime("%d %b %C")
  end
end
