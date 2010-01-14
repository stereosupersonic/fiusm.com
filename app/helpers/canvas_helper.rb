module CanvasHelper

  def canvas(canvas, *args)
    canvas.compile
  end
  
  def canvas_label(label, options = {})
    capture_haml { haml_tag :h4, label, :class => 'label' }
  end

end