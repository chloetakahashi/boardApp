module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
                'SAMPLE BOARD APP（管理画面）'
    else
      'SAMPLE BOARD APP'
    end

    page_title.empty? ? base_tiitle : page_title + ' | ' + base_title
  end

  def active_if(path)
    path == controller_path ? 'active' : ''
  end
end
