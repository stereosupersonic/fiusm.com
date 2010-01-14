module Arena
  class Table < Arena::HtmlView
    
    include Tables::Base
    include Tables::Data
    include Tables::Sections
    
    protected

      def content
        content_tag :td do
          if block_given?
            yield
          else
            header
            body
            footer
          end
        end
      end
      
      def table_content
        
      end

      def attributes_to_display
        @options[:attributes] || @model.columns.collect{|c| c.name.to_sym }
      end

  end
end