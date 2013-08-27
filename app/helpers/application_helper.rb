module ApplicationHelper

  def active_link_to(label, path, options = {})
    options[:class] = "active" if current_page?(path)
    link_to(label, path, options)
  end

end
