module Arena::Tables::Base

  class Cell < Arena::HtmlView
    def initialize(data, options = {}, &block)
      @data = data
      super(options, &block)
    end

    def compile
      concat content_tag(:td, content)
    end

    def content
      @data
    end
  end

  class HeaderCell < Cell
    def content
      super.to_s.humanize
    end

    def compile
      concat content_tag(:th, content)
    end
  end
  
  class Row < Arena::BuilderView
    def compile
      b.tr(block_given? ? yield : '')
    end
  end

  class EdgeRow < Row
    def initialize(attributes, options = {})
      @attributes = attributes
      super(options)
    end

    def compile
      b.tr do
        @attributes.each do |attribute|
          b << Arena::Table::HeaderCell.new(attribute)
        end
      end
    end
  end
  
end