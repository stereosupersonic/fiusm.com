module Arena::ActionView
  class TemplateHandler < ActionView::TemplateHandler
    include ActionView::TemplateHandlers::Compilable
    def self.call(template)
      template.source
    end
  end
end
