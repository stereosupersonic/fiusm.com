module Menu
  class Base < Item
    def initialize(controller, opts={},&block)
     @@controller = controller
      @opts       = {:class => 'menu'}.merge opts
      @level      = 0
      @children   = []

      yield self if block_given?
    end

    def to_s
      content_tag(:ul, @children.collect(&:to_s).join, @opts)
    end
    
    def separator
      @children << Separator.new(@level + 1)
    end
  end
end