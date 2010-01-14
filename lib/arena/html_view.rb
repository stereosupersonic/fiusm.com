module Arena  
  class HtmlView

    include Arena::HtmlViewExtensions::Buffer
    include Arena::HtmlViewExtensions::HtmlSafety
    include Arena::HtmlViewExtensions::Context

    cattr_accessor :context
    
    def context
      self.class.context
    end

    def self.with_context(context)
      klass = Class.new(self)
      klass.context = context
      klass
    end

    def initialize(*args, &block)
      @options = args.extract_options!
      @block   = block if block_given?
    end

    def to_html
      compile
      safe_buffer
    end

    def to_s
      to_html
    end
  
    def inspect
      "#<#{self.class.to_s}>"
    end

    protected

      def compile
        concat content(&@block)
      end

      def content
        raise "At the least, #content must be implemented"
      end

  end
end