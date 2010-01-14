class Arena::DataCellFinder

  class << self
    def find_for(record, attribute)
      new(record, attribute).result
    end
  end
  
  def initialize(record, attribute)
    @record    = record
    @attribute = attribute
  end

  def result
    paths = ["Views::Admin::Articles",
             "Arena::Table" ]
    
    class_search(paths, possible_class_names)
  end
  
  protected

    def data
      @record.__send__(@attribute)
    end

    def possible_class_names
      possible_class_names_without_suffix.collect{|n| "#{n}Cell" }
    end
    
    def possible_class_names_without_suffix
      [classified_attribute] +
        ancestors_for_attribute(@attribute) +
        ancestors_for_instance(data)
    end
    
    def classified_attribute
      @attribute.to_s.classify
    end

    def ancestors_for_attribute(attribute)
      qualified_ancestors_for_class(classified_attribute.constantize)
    rescue NameError
      []
    end

    def ancestors_for_instance(instance)
      qualified_ancestors_for_class(instance.class)
    end
    
    def qualified_ancestors_for_class(klass)
      klass.ancestors.grep(Class).map(&:to_s)
    end

    def class_search(paths, classes)
      paths.each do |path|
        classes.each do |klass|
          constant = safe_constantize("#{path}::#{klass}")
          return constant if constant && constant.ancestors.include?(Arena::Table::DataCell)
        end
      end   
      
      safe_constantize "Arena::Views::DataCell"
    end
    
    def safe_constantize(target)
      begin
        target.constantize
      rescue
        nil
      end
    end

end