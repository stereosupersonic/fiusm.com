module Arena::HtmlViewExtensions::Context

  # include Arena::ActionView::Helper

  def self.included(base)
    base.class_eval do
      alias_method_chain :method_missing, :context
    end
  end

  def method_missing_with_context(method, *args, &proc)
    if context && context.respond_to?(method)
      context.send(method, *args, &proc)
    else
      return false if method.to_s == "_hamlout"
      method_missing_without_context(method, *args, &proc)
    end
  end

end