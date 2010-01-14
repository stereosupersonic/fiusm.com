module Scaffold
  class Controller < Admin::ApplicationController

    # Use inherited_resources to make this work magically
    # inherit_resources

    # Add the view path for some of our default views
    append_view_path('lib/scaffold/views')
  
    # Add the scaffold helper to help out with scaffolding duties
    helper Helper

    # Rescue if the template is missing with a default template
    rescue_from ActionView::MissingTemplate do
      begin
        render :template => params[:action]      
      rescue ActionView::MissingTemplate => exception
        if params[:action].to_sym == :show
          redirect_to :action => :edit
        else
          raise exception
        end
      end
    end
  
    helper_method :scaffold
    def scaffold
      action = params[:action].to_sym
      self.class.scaffolds[action]
    end
  
    cattr_accessor :scaffolds
    @@scaffolds = {}
  
    supported_actions = [:index, :show, :new, :create, :edit, :update, :destroy]
    supported_actions.each do |action|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def self.#{action}(&config)
          if block_given?
            scaffolds[:#{action}] = Scaffold::Config.new(&config)
          else
            super
          end
        end
      RUBY
    end

  end
end