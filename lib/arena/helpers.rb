module Arena::Helpers

  def table_for(model, options = {})
    table = Table.new(options)
    yield table.builder
    table.to_html
  end

  def url_for(options = {})
    unless options[:skip_namespace_prefix]
      prefix = @controller.controller_path.match(/^(.+)\/[^\/]+/)[1]
      unless prefix.nil? || [String, Hash].include?(options.class) || options == :back
        options = options.is_a?(Array) ? options.unshift(:admin) : [:admin, options]
      end
    end
    super(options)
  end

end