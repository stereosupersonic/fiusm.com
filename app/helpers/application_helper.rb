# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def box(name = nil, html_options = {})
    html_options[:class] = "box #{html_options[:class]}"
    haml_tag :div, html_options do
      haml_tag :h3, "<span>#{name}</span>"
      haml_tag :div, :class => 'inside clearfix' do
        yield if block_given?
      end
    end
  end

  def multilingual_hello
    ['Nei ho', 'Hello', 'Hola', 'Namaskar', 'Olá', 'Privet', 'Hallo', 'Bonjour', 'Salve'].rand
  end

  def inside_layout(layout, &block)
    @template.instance_variable_set("@content_for_layout", capture(&block))
 
    layout = layout.to_s.include?("/") ? layout : "layouts/#{layout}" if layout
    buffer = eval("_erbout", block.binding)
    buffer.concat(@template.render(:file => layout))
  end

end
