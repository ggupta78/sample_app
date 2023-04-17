module ApplicationHelper
  def full_page_title(page_title = '')
    base_title = 'Sample App'
    if page_title.empty?
      base_title
    else
      # Interpolation would mess up html special chars
      # "#{page_title} | #{base_title}"
      page_title + ' | ' + base_title
    end
  end
end
