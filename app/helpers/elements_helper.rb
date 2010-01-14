module ElementsHelper

  def renderable
    [Article]
  end

  def render_article(article, options = {})
    default_options = {
      :photo => true,
      :label => true,
      :byline => false
    }
    
    render_options = {
      :partial => article,
      :locals => { :options => options }
    }
    
    tag_content = render(:partial => article, :locals => { :options => options })
    haml_tag(:div, tag_content, :class => "article item #{options.delete(:class)}")
  end
  
  def render_image(image, options = {})
    options[:style] = (options[:style] == true ? :original : options[:style])
    haml_tag :div, :class => 'photo' do
      haml_tag :p, image_tag(image.file.url(options[:style])), :class => 'image'
      haml_tag :p, image.credit, :class => 'credit'
      haml_tag :p, image.caption, :class => 'caption'
    end  
  end

  def render(object_or_options = nil, extra_options = {}, &block)
    if object = renderable_object_from_options(object_or_options)
      method = "render_#{object.class.to_s.underscore}".to_sym
      raise ArgumentError, "#{object} (#{object.class}) is not renderable." unless respond_to?(method)
      capture_haml { send(method, object, extra_options, &block) }
    elsif object_or_options.nil? # TODO: Get rid of this
      nil
    else
      super
    end
  end
  
  def renderable_object_from_options(object_or_options)
    if renderable.include?(object_or_options.class)
      object_or_options
    elsif object_or_options.is_a? Hash
      renderable.each do |klass|
        sym = klass.to_s.underscore.to_sym
        return klass unless object_or_options[sym].nil?
      end
      nil
    end
  rescue Exception # TODO: Clean up
    false
  end
  
  def renderable_object_to_sym(klass)
    klass.class.to_s.underscore.to_sym
  end

end
