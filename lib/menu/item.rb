module Menu
  class Item
    include ActionView::Helpers::TagHelper,
            ActionView::Helpers::UrlHelper

    attr_accessor :children, :link

    def initialize(title, link, level, link_opts={})
      @title, @link, @level, @link_opts = title, link, level, link_opts
      @children = []
      
      @controller = controller
    end

    def add(title, link, link_opts={}, &block)
      returning(MenuItem.new(title, link, @level +1, link_opts)) do |adding|
        @children << adding
        yield adding if block_given?
      end
    end

    def to_s
      content_tag :li, link_to(@title, @link, @link_opts) + child_output, ({:class => 'active'} if active?)
    end

    def level_class
      "menu_level_#{@level}"
    end

    def child_output
      children.empty? ? '' : content_tag(:ul, @children.collect(&:to_s).join, :class => level_class)
    end

    def active?
      children.any?(&:active?) || on_current_page?
    end

    def on_current_page?
      current_page?(@link)
    end

    cattr_accessor :controller
    def controller # make it available to current_page? in UrlHelper
      @@controller
    end
  end
end