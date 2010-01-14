module Arena::HtmlViewExtensions::Buffer

  module ClassMethods
    def empty_buffer
      buffer_class.new
    end

    def buffer_class
      ActionView::SafeBuffer
    end

    def with_buffer(buffer)
      klass = Class.new(self) do
        cattr_accessor :buffer
        
        def buffer
          self.class.buffer
        end
        
        def buffer=(new_buffer)
          self.class.buffer = new_buffer
        end
      end
      klass.buffer = buffer
      klass
    end
  end
  
  module InstanceMethods
    def <<(string)
      concat(string)
    end

    def concat(string)
      buffer.concat(string.to_s)
    end

    def safe_buffer
      String.new(buffer.to_s).html_safe!
    end

    def buffer
      @buffer || clear_buffer
    end

    def buffer=(new_buffer)
      @buffer = new_buffer
    end

    def clear_buffer
      self.buffer = self.class.empty_buffer
    end
  end
  
  def self.included(base)
    base.class_eval do
      extend  ClassMethods
      include InstanceMethods
    end
  end

end