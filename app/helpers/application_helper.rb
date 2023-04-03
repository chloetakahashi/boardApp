module ApplicationHelper
  def page_title(page_titlle = '')
    base_title = 'SAMPLE BOARD APP'

    page_title.empty? ? base_tiitle : page_title + ' | ' + base_title
  end
end
