module Arena::ActionView::Helper

  # def self.included(base)
  #   base.class_eval do
  #     alias_method_chain :method_missing, :class_for_method
  #   end
  # end

  # def method_missing_with_class_for_method(method, *args, &proc)
  #   if klass = class_for_method(method)
  #     klass = klass.with_context(self) if self.is_a?(ActionView::Base)
  #     klass.new(*args, &proc)
  #   else
  #     method_missing_without_class_for_method(method, *args, &proc)
  #   end
  # end
  
  def class_for_method(method)
    classified_method = method.to_s.classify
    paths.each do |path|
      class_name = "#{path}::#{classified_method}"
      begin
        return class_name.constantize
      rescue NameError => exception
        expected = exception.message == "uninitialized constant #{class_name}"
        expected ? next : raise(exception)
      end
    end
    nil
  end
  
  def paths
    [path_for_root]
  end
  
  def path_for_current_controller
    "Views::#{controller_path.classify}"
  end
  
  def path_for_root
    Arena
  end

end