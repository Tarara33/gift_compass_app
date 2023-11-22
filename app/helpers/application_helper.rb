module ApplicationHelper
  def page_title(page_title = '')
    default_title = "Gift Conpass"
    page_title.empty? ? default_title : page_title + ' | ' + default_title
  end
end
