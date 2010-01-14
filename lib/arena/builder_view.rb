require 'builder'
module Arena
  class BuilderView < HtmlView
    
    def initialize(*args)
      # @xml_buffer = ''
      # @builder = Arena::XmlMarkup.new(:indent => 2, :target => @xml_buffer)
      super
    end
    
    def to_html
      compile
      concat(@xml_buffer.html_safe!)
      ''
    end
    
    protected
    def builder
      @builder
    end
    alias :b :builder
    
  end
end