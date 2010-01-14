module Nodes
  class Node

    attr_accessor :children, :parent
    
    def initialize(children = nil, parent = nil)
      raise ArgumentError unless children.nil? || children.is_a?(Collection)

      @children = children || collection_class.new(self)
      @parent   = parent
    end
    
    def collection_class
      Collection
    end

    def level
      @parent ? @parent.level + 1 : 1
    end

    def first?
      owner.first?(self)
    end

    def last?
      owner.last?(self)
    end

    def siblings
      owner - self
    end
      
    def first?
      @parent.children.first == self
    end

    def last?
      @parent.children.last == self
    end

  end
end