module Arena
  class TemplateResolver < ::ActionView::FileSystemResolver

    def initialize(options = {})
      templates_path = File.expand_path('../views/templates/', __FILE__)
      super(templates_path, options)
    end
    
    def find_templates_with_removed_prefix(name, details, prefix, partial)
      find_templates_without_removed_prefix(name, details, '', partial)
    end
    alias_method_chain :find_templates, :removed_prefix
    
  end
end