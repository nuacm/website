module ApplicationHelper

  def active_link_to(label, path, options = {})
    options[:class] = "active" if current_page?(path)

    if options.delete(:li)
      content_tag :li, options do
        link_to(label, path)
      end
    else
      link_to(label, path, options)
    end
  end

end
