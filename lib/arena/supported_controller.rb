require 'inherited_resources'
module Arena
  module SupportedController
    def self.included(base)
      base.class_eval do
        # import helper
        helper Arena::ActionView::Helper
        
        # add our wonderful resolver
        view_paths << TemplateResolver.new
      end

      # and the template handler too
      ::ActionView::Template.register_default_template_handler :arb, Arena::ActionView::TemplateHandler
    end
  end
end