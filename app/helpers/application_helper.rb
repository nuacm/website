module ApplicationHelper

  def active_link_to(label, path, options = {})
    options[:class] = "active" if current_page?(path)
    link_to(label, path, options)
  end

  def bigpic
    pool = [
      'https://farm9.staticflickr.com/8323/8429149142_04932dfa25_k.jpg',
      'http://farm6.staticflickr.com/5538/9145652131_e87e9e4bf3_k.jpg ',
      'http://farm9.staticflickr.com/8054/8429138978_98e1d89081_k.jpg ',
      'http://farm9.staticflickr.com/8096/8428048907_cb647a407a_k.jpg ',
      'http://farm9.staticflickr.com/8185/8429149728_0020113ebf_k.jpg ',
      'http://farm9.staticflickr.com/8376/8428058045_ca1ca3bcb1_k.jpg ',
      'http://farm9.staticflickr.com/8044/8428059529_7e5959ebee_k.jpg ',
      'http://farm9.staticflickr.com/8366/8428064063_55c9ed2e2e_k.jpg '
    ]

    content_tag(:div, "", :class => "pitch", :style => "background-image: url('#{pool.sample}')")
  end

end
