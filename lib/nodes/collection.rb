module Nodes
  class Collection < Array

    def initialize(owner, size = 0, object = nil, skip_initialize = nil)
      @owner  = owner
      @object = object
      skip_initialize ? super(size) : super(size, object)
    end

    def <<(node)
      node.parent = @owner
      super
    end
    
    def first?(node)
      first == node
    end
    
    def last?(node)
      last == node
    end

    def after(node)
      before_or_after_node(node, :after)
    end

    def before(node)
      before_or_after_node(node, :before)
    end

    private
      def before_or_after_node(node, before_or_after = :after)
        op = before_or_after == :after ? :+ : :-
        at(index(node).send(op, 1))
      end
    
  end
end