class FormBuilder < ActionView::Helpers::FormBuilder

  helpers = field_helpers +
            %w{date_select datetime_select time_select} +
            %w{collection_select select country_select time_zone_select} -
            %w{hidden_field label fields_for} # Don't decorate these  

  helpers.each do |name|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{name}(field, *args)
        options = args.extract_options!
        label = options[:label] == false ? nil : label(field, options[:label], :class => options[:label_class])
        content = label_and_field(label, super, field_swappable?(:#{name}))
        field_wrapper(:#{name}, content)
      end
    RUBY
  end

  def submit(value = nil, options = {})
    field_wrapper(:submit, super)
  end

  def field_wrapper(field_type, content)
    object_name = @object_name.to_s.gsub('[', '_').gsub(']', '').to_sym
    @template.content_tag(:p, content, :class => "clearfix field #{field_type}", :id => "#{object_name}_#{field_type}_field")
  end

  def field_swappable?(field_kind)
    [:check_box].include?(field_kind)
  end
  
  def label_and_field(label, field, swap = false)
    swap ? "#{field}#{label}" : "#{label}#{field}"
  end

end