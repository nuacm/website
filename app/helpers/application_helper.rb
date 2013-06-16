module ApplicationHelper

  def current_link_to(label, path, options = {})
    options[:class] = "current" if current_page?(path)
    link_to(label, path, options)
  end

end
